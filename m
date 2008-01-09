Return-Path: <neko@genesi-usa.com>
Received: from ug-out-1314.google.com (ug-out-1314.google.com [66.249.92.174])
	by ozlabs.org (Postfix) with ESMTP id 2C322DDE20
	for <linuxppc-dev@ozlabs.org>; Thu, 10 Jan 2008 03:32:17 +1100 (EST)
Received: by ug-out-1314.google.com with SMTP id q7so109983uge.0
	for <linuxppc-dev@ozlabs.org>; Wed, 09 Jan 2008 08:32:14 -0800 (PST)
Message-ID: <4784F7D1.1050301@genesi-usa.com>
Date: Wed, 09 Jan 2008 16:35:29 +0000
From: Matt Sealey <matt@genesi-usa.com>
MIME-Version: 1.0
To: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: add phy-handle property for fec_mpc52xx
References: <20080109140608.GA15673@aepfle.de> <4784E78C.40904@genesi-usa.com>
	<fa686aa40801090746k4ec5c208j9daf224cb2570071@mail.gmail.com>
In-Reply-To: <fa686aa40801090746k4ec5c208j9daf224cb2570071@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Sender: Matt Sealey <neko@genesi-usa.com>
Cc: linuxppc-dev@ozlabs.org, Olaf Hering <olaf@aepfle.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


Grant Likely wrote:
> On 1/9/08, Matt Sealey <matt@genesi-usa.com> wrote:
>> Please let's keep the nature of our firmware and the Linux codebase
>> independant, and move the burden of support to Genesi, and not the
>> Linux PowerPC team. After all, what is next, after phy-handle do
>> you want to add i2c, irda, missing xlb/cdm entries in the patch so
>> that other things work? Does everyone have to custom compile their
>> own kernel? What happens if we do another firmware release and
>> the Linux kernel overwrites important values without checking as
>> it does now? It simply causes problems.
> 
> FWIW, I've got a patch in my tree that removes a bunch of the efika
> fixups.  I've learned a lot over the past year and I'm taking a more
> pragmatic approach.  So, fixups that are not absolutely required to
> get a working Efika are going away.
> 
> However, I'm still inclined to pick up Olaf's patch with the
> appropriate protections around it so it is only done if the nodes are
> missing.

Eh.. yeah. Maybe. Seems like a cop-out to me. I would rather you removed
the patch and called us a bunch of idiots for coding bad firmware, than
have the fixups be dependant on what could turn into a very well coded
but essentially screen-long list of fixups for myriad firmware versions
where the properties may or may not be present or correct for various
firmware versions and devices.

Grant, are you any good at coding firmware-level stuff without utilizing
any preexisting code under the GPL? I'd like to collaborate on an installer
tool which can put efika.forth (and therefore all these fixes) in.

The end result would be efika_device_tree_fixups() reporting if you have
an old firmware and saying, things may not work. efika.forth is steering
towards hacking /openprom/built-on with an appropriate date for firmware
and device tree version checking, so any date lower than the appropriate
script or firmware version can be warned about.

(a similar tactic is employed by lmsensors if you have a Via SMB driver
loaded but the BIOS has left the SMB block in the southbridge disabled,
it says you need to update your BIOS or use force=1 and leaves it non
working. You will see this on Pegasos. I like this tactic, just not the
recommendation to update your BIOS when it may or may not exist.. a
simple warning that some devices may not work correctly is essential though)

-- 
Matt Sealey <matt@genesi-usa.com>
Genesi, Manager, Developer Relations
