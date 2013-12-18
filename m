Return-Path: <mpe@ellerman.id.au>
Message-ID: <1387344458.20735.2.camel@concordia>
Subject: Re: [PATCH v2] powerpc/powernv: Framework to log critical errors on
 powernv.
From: Michael Ellerman <mpe@ellerman.id.au>
To: Deepthi Dharwar <deepthi@linux.vnet.ibm.com>
Date: Wed, 18 Dec 2013 16:27:38 +1100
In-Reply-To: <52B13019.4010601@linux.vnet.ibm.com>
References: <52AEF27F.3070202@linux.vnet.ibm.com>
 <1387334600.19507.5.camel@concordia> <52B13019.4010601@linux.vnet.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: PowerPC email list <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2013-12-18 at 10:48 +0530, Deepthi Dharwar wrote:
> Hi Micheal,
> 
> Thanks for the review.

No worries.
 
> On 12/18/2013 08:13 AM, Michael Ellerman wrote:
> > On Mon, 2013-12-16 at 18:00 +0530, Deepthi Dharwar wrote:
> >> +/* All the information regarding an error/event to be reported
> >> + * needs to populate this structure using pre-defined interfaces
> >> + * only
> >> + */
> >> +struct opal_errorlog {
> >> +
> >> +	uint16_t component_id;
> >> +	uint8_t error_events_type:3;
> > 
> > Bit field?
> > 
> >> +	uint8_t subsystem_id;
> >> +
> >> +	uint8_t event_sev;
> >> +	uint8_t event_subtype;
> >> +	uint8_t usr_scn_count; /* User section count */
> > 
> > user_section_count;
> > 
> >> +	uint8_t elog_origin;
> >> +
> >> +	uint32_t usr_scn_size; /* User section size */
> > 
> > user_section_size;
> > 
> >> +	uint32_t reason_code;
> >> +	uint32_t additional_info[4];
> >> +
> >> +	char usr_data_dump[OPAL_LOG_MAX_DUMP];
> >> +};
> > 
> > It looks like this goes straight to Opal, should we be using __packed ?
> 
> Yes, this goes straight into Opal. The structure is defined such that
> it is packed by default, this will not require compiler to pack bytes.

Sure, but the compiler might decide to lay it out differently for some reason.
You should use __packed.

Also bitfields are essentially a big "implementation defined behaviour" sign,
so I would avoid using the bitfield.

> >> diff --git a/arch/powerpc/platforms/powernv/opal-elog.c b/arch/powerpc/platforms/powernv/opal-elog.c
> >> index 58849d0..ade1e58 100644
> >> --- a/arch/powerpc/platforms/powernv/opal-elog.c
> >> +++ b/arch/powerpc/platforms/powernv/opal-elog.c
> >> @@ -22,7 +23,9 @@
> >>  /* Maximum size of a single log on FSP is 16KB */
> >>  #define OPAL_MAX_ERRLOG_SIZE	16384
> >>  
> >> -/* maximu number of records powernv can hold */
> >> +#define USR_CHAR_ARRAY_FIXED_SIZE      4
> > 
> > What is this?
> 
> struct User data section is mapped to a buffer. As all the structures
> are padded, we need to subtract the same to do data manipulation.
> Make me need to re-word it or use __packed here.

Yeah that's still not really clear to me, so if you can do something that is
more obvious that would be good.

> >> @@ -272,6 +275,61 @@ static int init_err_log_buffer(void)
> >>  	return 0;
> >>  }
> >>  
> >> +/* Interface to be used by POWERNV to push the logs to FSP via Sapphire */
> >> +struct opal_errorlog *elog_create(uint8_t err_evt_type, uint16_t component_id,
> >> +		uint8_t subsystem_id, uint8_t event_sev, uint8_t  event_subtype,
> >> +		uint32_t reason_code, uint32_t info0, uint32_t info1,
> >> +		uint32_t info2, uint32_t info3)
> > 
> > 
> > A call to this function is going to be just a giant list of integer values, it
> > will not be easy to see at a glance which value goes in which field.
> > 
> > I think you'd be better off with an elog_alloc() routine, and then you just do
> > the initialisation explicitly so that it's obvious which value goes where:
> > 
> > 	elog->error_events_type = FOO;
> > 	elog->component_id = BAR;
> > 	elog->subsystem_id = ETC;
> > 
> 
> elog_create() will be called by all sub-systems on POWERNV platform to
> log events and errors. I feel we are better off passing all the required
> arguments to the interface than initialize explicitly.
> This would have a cleaner interface to error logging by
> 1) Removing huge amount of code duplication ( Each and every error/event
> to be reported needs to initialise fields of the opal_errorlog struct
> done many many times on POWERNV, results in redundant code )

It will be more lines of code, but it might be more readable code.

> 2) There are chances of missing out on initialising key fields if
> done by the user. Having an interface mandates the fields that
> needs to populated while logging error/events.

I can always pass 0 :)

We will see how it looks once there are some callers.

> >> +void commit_errorlog_to_fsp(struct opal_errorlog *buf)
> >> +{
> >> +	opal_commit_log_to_fsp((void *)(vmalloc_to_pfn(buf) << PAGE_SHIFT));
> > 
> > Can't fail?
> 
> It is better to have a return here, atleast for the caller to know if
> opal handling of the same is successful or not. I will make the required
> change.
> 
> >> +	kfree(buf);
> > 
> > It's a bit rude to free buf when the caller still has a pointer to it.
> 
> Technically, after the error log has been committed, the user is not
> supposed to re-use or do anything with that buffer. I need to add
> checks in all my routines if(buf != NULL), to handle the case where
> the user by mistake is trying to use the same buffer pointer.

Why is the user not supposed to re-use it?

kfree()'ing the buffer doesn't prevent the caller from re-using it.

cheers
