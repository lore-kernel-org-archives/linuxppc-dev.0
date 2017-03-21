Return-Path: <npiggin@gmail.com>
Date: Tue, 21 Mar 2017 15:27:45 +1000
From: Nicholas Piggin <npiggin@gmail.com>
To: Stewart Smith <stewart@linux.vnet.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org, skiboot@lists.ozlabs.org
Subject: Re: [Skiboot] [PATCH][OPAL] cpufeatures: add base and POWER8,
 POWER9 /cpus/features dt
Message-ID: <20170321152745.4a3e1f36@roar.ozlabs.ibm.com>
In-Reply-To: <87a88fw89d.fsf@linux.vnet.ibm.com>
References: <20170307111326.28129-1-npiggin@gmail.com>
 <20170307111326.28129-2-npiggin@gmail.com>
 <87a88fw89d.fsf@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 21 Mar 2017 15:42:22 +1100
Stewart Smith <stewart@linux.vnet.ibm.com> wrote:

> Nicholas Piggin <npiggin@gmail.com> writes:
> > With this patch and the Linux one, I can boot (in mambo) a POWER8 or
> > POWER9 without looking up any cpu tables, and mainly looking at PVR
> > for MCE and PMU.  
> 
> That's pretty neat. I now await the day where somebody produces a chip
> with uneven feature sets between cores.
> 
> > Machine and ISA speicfic features that are not abstracted by firmware
> > and not captured here will have to be handled on a case by case basis,
> > using PVR if necessary. Major ones that remain are PMU and machine
> > check.  
> 
> At least for machine check we could probably get something "good enough"
> without too much effort.

Machine check I'd like to put it in opal with a special case entry from
the hypervisor. At the moment it just has a lot of implementation specific
decoding of bits, and we can't really call opal to do anything useful
with normal call because it re-enters the stack.

> For PMU, I wonder if we could get something that's suitably common with
> the IMC work being done so that we could "just work" on new PMUs (albeit
> calling into OPAL for enable/disable)

I don't know the PMU code, but if we could have some kind of firmware
fallback like that it would be perfect.

For machine specific implementations that are faster or more capable,
I guess looking at PVR is not taboo as such. Just that it shouldn't
be needed to boot and get some reasonable baseline. 

> > Open question is where and how to develop and document these features?
> > Not the dt representation created by skiboot, but the exact nature of
> > each feature. What exact behaviour does a particular feature imply,
> > etc.  
> 
> Part of me seems to think this could be something for the Architecture,
> and then we just have a 1-to-1 mapping of the arch bits and we're all
> one big happy family....
> 
> Benh/Paulus can probably laugh at me suitably hard for suggesting such a
> thing being possible though :)

I think to a degree we might be moving in that direction. Probably
can't say much more in public at the moment, but at least this dt
implementation must be flexible enough to cope with a range of
approaches we might decide to take (fine/coarse grained, fscr bits
or not, etc).

> I see the kernel patch has docs for the DT bindings, I'd like to also
> keep a copy in the skiboot tree, if only to further my impossible quest
> to somewhat document the OPAL ABI.

That can be arranged.

> > diff --git a/core/device.c b/core/device.c
> > index 30b31f46..1900ba71 100644
> > --- a/core/device.c
> > +++ b/core/device.c
> > @@ -548,6 +548,13 @@ u32 dt_property_get_cell(const struct dt_property *prop, u32 index)
> >  	return fdt32_to_cpu(((const u32 *)prop->prop)[index]);
> >  }
> >  
> > +void dt_property_set_cell(struct dt_property *prop, u32 index, u32 val)
> > +{
> > +	assert(prop->len >= (index+1)*sizeof(u32));
> > +	/* Always aligned, so this works. */
> > +	((u32 *)prop->prop)[index] = cpu_to_fdt32(val);
> > +}
> > +
> >  /* First child of this node. */
> >  struct dt_node *dt_first(const struct dt_node *root)
> >  {
> > diff --git a/core/init.c b/core/init.c
> > index 58f96f47..938920eb 100644
> > --- a/core/init.c
> > +++ b/core/init.c
> > @@ -703,6 +703,8 @@ static void per_thread_sanity_checks(void)
> >  /* Called from head.S, thus no prototype. */
> >  void main_cpu_entry(const void *fdt);
> >  
> > +extern void mambo_add_cpu_features(struct dt_node *root);
> > +
> >  void __noreturn __nomcount main_cpu_entry(const void *fdt)
> >  {
> >  	/*
> > @@ -774,6 +776,7 @@ void __noreturn __nomcount main_cpu_entry(const void *fdt)
> >  			abort();
> >  	} else {
> >  		dt_expand(fdt);
> > +		mambo_add_cpu_features(dt_root);
> >  	}  
> 
> (without checking closely, just going from memory), this would also the
> the case on P8 OpenPOWER hardware, as we get the device tree from
> Hostboot there too.

Okay I'll look into it.

> >  	/* Now that we have a full devicetree, verify that we aren't on fire. */
> > diff --git a/hdata/cpu-common.c b/hdata/cpu-common.c
> > index aa2752c1..1da1b1cb 100644
> > --- a/hdata/cpu-common.c
> > +++ b/hdata/cpu-common.c  
> 
> > +	{ "vector-crypto",
> > +	CPU_ALL,
> > +	ISA_BASE, USABLE_HV|USABLE_OS|USABLE_PR,
> > +	HV_SUPPORT_NONE, OS_SUPPORT_NONE,
> > +	-1, -1, 38,
> > +	"vector", },  
> 
> Did we want to break this down at all? Specifically maybe just the AES
> instructions?
> 
> AFAIK it's been the only set where there was some amount of discussion
> about somebody possibly not wanting to include.

I don't have much opinion on it. Userspace has only the one feature bit
there, so missing part of the instructions would have to disable the
entire thing.

That's not to say we couldn't add another bit and start getting userspace
to use it. So if there is some need or strong potential future need,
we should consider it.

Thanks,
Nick
