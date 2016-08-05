Return-Path: <petkan@mip-labs.com>
Received: from zztop.nucleusys.com (lan.nucleusys.com [92.247.61.126])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3s5Wd431kfzDqV1
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  6 Aug 2016 01:56:23 +1000 (AEST)
Date: Fri, 5 Aug 2016 18:56:02 +0300
From: Petko Manolov <petkan@mip-labs.com>
To: Mimi Zohar <zohar@linux.vnet.ibm.com>
Cc: linux-security-module@vger.kernel.org,
 linux-ima-devel@lists.sourceforge.net,
 Dave Young <dyoung@redhat.com>, kexec@lists.infradead.org,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>
Subject: Re: [PATCH 1/7] ima: on soft reboot, restore the measurement list
Message-ID: <20160805155602.GA1738@localhost>
References: <1470313475-20090-1-git-send-email-zohar@linux.vnet.ibm.com>
 <1470313475-20090-2-git-send-email-zohar@linux.vnet.ibm.com>
 <20160805084425.GA7572@localhost>
 <1470404078.2471.123.camel@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <1470404078.2471.123.camel@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 16-08-05 09:34:38, Mimi Zohar wrote:
> Hi Petko,
> 
> Thank you for review!
> 
> On Fri, 2016-08-05 at 11:44 +0300, Petko Manolov wrote:
> > On 16-08-04 08:24:29, Mimi Zohar wrote:
> > > The TPM PCRs are only reset on a hard reboot.  In order to validate a
> > > TPM's quote after a soft reboot (eg. kexec -e), the IMA measurement list
> > > of the running kernel must be saved and restored on boot.  This patch
> > > restores the measurement list.
> > > 
> > > Changelog:
> > > - call ima_load_kexec_buffer() (Thiago)
> > > 
> > > Signed-off-by: Mimi Zohar <zohar@linux.vnet.ibm.com>
> > > ---
> > >  security/integrity/ima/Makefile       |   1 +
> > >  security/integrity/ima/ima.h          |  10 ++
> > >  security/integrity/ima/ima_init.c     |   2 +
> > >  security/integrity/ima/ima_kexec.c    |  55 +++++++++++
> > >  security/integrity/ima/ima_queue.c    |  10 ++
> > >  security/integrity/ima/ima_template.c | 171 ++++++++++++++++++++++++++++++++++
> > >  6 files changed, 249 insertions(+)
> > >  create mode 100644 security/integrity/ima/ima_kexec.c
> > > 
> > > diff --git a/security/integrity/ima/Makefile b/security/integrity/ima/Makefile
> > > index c34599f..c0ce7b1 100644
> > > --- a/security/integrity/ima/Makefile
> > > +++ b/security/integrity/ima/Makefile
> > > @@ -8,4 +8,5 @@ obj-$(CONFIG_IMA) += ima.o
> > >  ima-y := ima_fs.o ima_queue.o ima_init.o ima_main.o ima_crypto.o ima_api.o \
> > >  	 ima_policy.o ima_template.o ima_template_lib.o ima_buffer.o
> > >  ima-$(CONFIG_IMA_APPRAISE) += ima_appraise.o
> > > +ima-$(CONFIG_KEXEC_FILE) += ima_kexec.o
> > >  obj-$(CONFIG_IMA_BLACKLIST_KEYRING) += ima_mok.o
> > > diff --git a/security/integrity/ima/ima.h b/security/integrity/ima/ima.h
> > > index b5728da..84e8d36 100644
> > > --- a/security/integrity/ima/ima.h
> > > +++ b/security/integrity/ima/ima.h
> > > @@ -102,6 +102,13 @@ struct ima_queue_entry {
> > >  };
> > >  extern struct list_head ima_measurements;	/* list of all measurements */
> > >  
> > > +/* Some details preceding the binary serialized measurement list */
> > > +struct ima_kexec_hdr {
> > > +	unsigned short version;
> > > +	unsigned long buffer_size;
> > > +	unsigned long count;
> > > +} __packed;
> > 
> > Unless there is no real need for this structure to be packed i suggest 
> > dropping the attribute.  When referenced through pointer 32bit ARM and MIPS 
> > (and likely all other 32bit RISC CPUs) use rather inefficient byte loads and 
> > stores.
> > 
> > Worse, if, for example, ->count is going to be read/written concurrently 
> > from multiple threads we get torn loads/stores thus losing atomicity of the 
> > access.
> 
> This header is used to prefix the serialized binary measurement list with some 
> meta-data about the measurement list being restored. Unfortunately 
> kexec_get_handover_buffer() returns the segment size, not the actual ima 
> measurement list buffer size.  The header info is set using memcpy() once in 
> ima_dump_measurement_list() and then the fields are used in 
> ima_restore_measurement_list() to verify the buffer.

As long as there is no concurrent reads/writes this should be OK.

> The binary runtime measurement list is packed, so the other two structures - 
> binary_hdr_v1 and binary_data_v1 - must be packed.  Does it make sense for 
> this header not to be packed as well?  Would copying the header fields to 
> local variables before being used solve your concern?

Copying to aligned variables would be necessary only if:

	a) some sort of atomicity is needed, and/or
	б) speed is of concern;

> Remember this code is used once on the kexec execute and again on reboot.

If we don't need a) _and_ b) then you don't need to bother.


		Petko
