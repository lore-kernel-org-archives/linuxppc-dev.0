Content-Type: text/plain;
  charset="iso-8859-1"
From: "Kevin B. Hendricks" <kevin.hendricks@sympatico.ca>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	yellowdog-devel@lists.yellowdoglinux.com,
	linuxppc-dev@lists.linuxppc.org
Subject: Re: some questions on new dual 1Gig G4's support?
Date: Sun, 3 Feb 2002 14:02:43 -0500
References: <20020202144614.WRFZ11118.tomts10-srv.bellnexxia.net@there> <20020202201115.17827@smtp.wanadoo.fr>
In-Reply-To: <20020202201115.17827@smtp.wanadoo.fr>
MIME-Version: 1.0
Message-Id: <20020203185831.MQZJ9396.tomts12-srv.bellnexxia.net@there>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi Ben,

> Out of my mind, there are 3 places you want to look at:
>
> cputable.c : add an entry & declare a specific setup_cpu function
> for the 7455

Done


> head.S : add the setup_cpu for the 7455, possibly copying the one
> of the 7450.

Done, I have simply copied the 7540 one until I get a chance to study the
pdfs to see what else changed in hid0 (there are 2 new bits I think, 1 to
enable extra bats and one other one).

>Then go figure if the L3 is also incompatible with
> NAP mode or not. If it is not, you can strip the code that clears
> the "can DOZE" feature. Note that ideally, we should change that
> code to be 2 different feature bits, one for can DOZE, and one for
> can NAP (as the 7450/55 can only NAP, not DOZE).
> You can change that easily, basically define the new bit for NAP
> in cputable.h, set it for all CPUs (except 7450 rev 2.0) in
> cputable, and remove DOZE capability from 7450/55. Once done,
> tweak the code in arch/ppc/kernel/idle.c so that it does power
> save if either of these bits is set, but also make sure it does
> not try to NAP if powersave_nap isn't set (as some host bridges
> can't handle it, it will be set properly by pmac_feature).
> If your CPU can't DOZE but can NAP, but powersave_nap is false,
> do nothing.

Is this L3 cache problem with DOZE and NAP an errata for 7450?  I looked
in the updates 7450 manual (with 7455 specifics already added to it) and I
did not see any limitations on NAP or DOZE (it is 840 some pages long so
perhaps I am not looking in the right places yet).

> pmac_feature.c : add an entry in the machine table for your machine
> based on OF "model" property.

According to the Apple developers note just released for this machine its
model ID is simply "PowerMac3,5" which is unchanged from previous versions
and already covered in the pmac_feature.c file.

So I will spend my time reading up on NAP and DOZE and trying to see if
and how that has changed since the 7450.

Thanks for all your help!

Kevin


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
