Return-Path: <glikely@secretlab.ca>
Received: from an-out-0708.google.com (an-out-0708.google.com [209.85.132.244])
	by ozlabs.org (Postfix) with ESMTP id B0C36DDF02
	for <linuxppc-dev@ozlabs.org>; Thu, 15 May 2008 01:35:30 +1000 (EST)
Received: by an-out-0708.google.com with SMTP id c34so887702anc.78
	for <linuxppc-dev@ozlabs.org>; Wed, 14 May 2008 08:35:28 -0700 (PDT)
Message-ID: <fa686aa40805140835v14b9ff85od01e74985e8e3586@mail.gmail.com>
Date: Wed, 14 May 2008 09:35:27 -0600
From: "Grant Likely" <grant.likely@secretlab.ca>
Sender: glikely@secretlab.ca
To: "Stephen Neuendorffer" <stephen.neuendorffer@xilinx.com>
Subject: Re: [PATCH] Xilinx: framebuffer: add compatibility for ml507 dvi core.
In-Reply-To: <20080512195905.8DD2717B805C@mail2-dub.bigfish.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <20080505175918.2AD03A58056@mail164-sin.bigfish.com>
	<fa686aa40805120724u17a380adnd0826044ae3ac369@mail.gmail.com>
	<20080512173130.0D747181804D@mail89-sin.bigfish.com>
	<fa686aa40805121130n53b14a8fye692e06616dc3bc7@mail.gmail.com>
	<20080512191025.67682630064@mail160-dub.bigfish.com>
	<fa686aa40805121246i68c42867k150c5f9e0082598f@mail.gmail.com>
	<20080512195905.8DD2717B805C@mail2-dub.bigfish.com>
Cc: linuxppc-dev@ozlabs.org, git-dev <git-dev@xilinx.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, May 12, 2008 at 1:59 PM, Stephen Neuendorffer
<stephen.neuendorffer@xilinx.com> wrote:
>
>
>> -----Original Message-----
>> From: glikely@secretlab.ca [mailto:glikely@secretlab.ca] On Behalf Of
> Grant Likely
>> Sent: Monday, May 12, 2008 12:46 PM
>> To: Stephen Neuendorffer
>> Cc: linuxppc-dev@ozlabs.org; git-dev
>> Subject: Re: [PATCH] Xilinx: framebuffer: add compatibility for ml507
> dvi core.
>>
>> On Mon, May 12, 2008 at 1:10 PM, Stephen Neuendorffer
>> <stephen.neuendorffer@xilinx.com> wrote:
>> >
>> >  The best possibility that I see is glopping the compatibility
>> >  information about what cores are compatible with which drivers and
>> >  generating something.  This is moderately better than blindly
> treating
>> >  all cores with the same major version as interface compatible, but
> still
>> >  has the potential to blindly declare that core versions are
> compatible
>> >  when they are not really compatible.
>>
>> That's okay, the device tree conventions provide for that uncertainty.
>>  If compatible includes both the *exact* version and the oldest known
>> *compatible* version (the one the drivers know about) then we're in
>> the situation where 99% of the time it just works.  For the 1% of the
>> time when mistakes are made we still have the necessary information to
>> write exceptions in the code to work around bad data.  This means code
>> only needs to changes when mistakes are discovered, not for every IP
>> core uprev.
>
> My argument was that we should do this by truncating the major version,
> which is also an established standard that cores *should* follow, but
> you didn't like that. :)  It makes at least as much sense as expressing
> the compatibility of the driver in the tree in terms of compatibility
> with some other random driver.  In the case of the tft core in
> particular, there *is* no other driver AFAIK.

The whole point of compatible is to describe software interfaces...
*if* a device is register level backwards compatible with an older
already supported device, *then* it is appropriate to claim
compatibility with it.  True, the TFT core is not the same as the VGA
core.  But (as your patch suggests) the register interface is
backwards compatible.

As for truncating the major version; you're right, I don't like it,
but that doesn't mean I cannot be swayed.  Best argument is to
analogize it with a similar SoC situation.  A particular SoC (let's
say the MPC8349) will have several revisions to it, but none of that
is reflected in the device tree.  It's just referred to as
"fsl,mpc8349".  Actual silicon revision is obtainable by software from
the PVR/SVR if it *really* needs it.  The counter example is the
MPC5200/MPC5200b where the 'b' version is explicitly specified in the
compatible list (see arch/powerpc/boot/dts/lite5200b.dts).  The 5200b
is 99% compatible with the original 5200, with only a couple of on
chip peripherals not being register level compatible.  I'm still not
completely certain that "fsl,mpc5200b-<blah>" was the right decision,
but by being conservative early on means that I can still drop most of
the 'b' specifiers at some point in the future without breaking board
support.

What makes me nervous about FPGA IP cores is that the potential for
change is much higher than for an SoC.  SoC vendors get very angry
customers if a silicon uprev breaks their drivers; especially
considering that they could very easily have boards with both the old
and new silicon.  It does not seem to me like there is quite the same
level of pressure too keep the register level interface 100%
compatible.  So this is the pressure point to apply if you want to
change my mind.  How confident are you that the major (or minor)
revision will remain register level compatible?

n>> >  I *really* don't want to put this into the device tree generator on
> a
>> >  case-by-case basis, so unless there is something that can be
> generated
>> >  from whatever meta-information EDK has, I think we're going to have
> to
>> >  just have the explicit versions in the drivers for the time being.
>>
>> Can we post process the generated device tree with a table of known
>> compatibility strings (or regexps) for adding the older compatible
>> values?  I don't expect the list will be particularly long or hard to
>> maintain and the code to do so should be trivial.
>
> Ug, that's just pushing the problem around.
> This seems as much like an argument for putting wildcards in the
> compatible bindings in the kernel as anything...

Not quite.  There is a difference between method used to generate the
data, and how the data is interpreted by the kernel (the boundary
being what data is actually passed to the kernel).  If the tool
generates bad/inaccurate data, then it is a bug and it should be
fixed.  Even better, it is a bug that will be found quickly because
the device simply won't work if it binds to the wrong driver.  I do
not want to load knowledge of all those permutation into the kernel
image.

(But I do agree that my suggestion was rather smelly)

As for wildcards, the big problem is that the definition of a wildcard
changes over time as new devices are released.  Consider this;
aesthetics aside, what is the difference between using
"xlnx,plb-tft-cntlr-ref-1.xx" and "xlnx,plb-tft-cntlr-ref-1.00.a" as a
'generic' compatible value?  The value still needs to be coded into
the tool somewhere; but the second one is anchored to a single real
implementation which means that it's definition is fixed.

I know I'm being very conservative here; but it is safer to be
conservative now and relax stuff later than the other way around.
Being liberal is what got arch/ppc into the whole bdinfo_t mess in the
first place.

Cheers,
g.

-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
