Return-Path: <glikely@secretlab.ca>
Received: from mail-px0-f171.google.com (mail-px0-f171.google.com
	[209.85.216.171]) by ozlabs.org (Postfix) with ESMTP id E843DB7CEF
	for <linuxppc-dev@ozlabs.org>; Fri, 26 Mar 2010 08:54:33 +1100 (EST)
Received: by pxi1 with SMTP id 1so3689999pxi.10
	for <linuxppc-dev@ozlabs.org>; Thu, 25 Mar 2010 14:54:32 -0700 (PDT)
MIME-Version: 1.0
Sender: glikely@secretlab.ca
In-Reply-To: <4BABC1CF.1000306@freescale.com>
References: <1269380552-10418-1-git-send-email-timur@freescale.com>
	<4BAB7E67.6040707@freescale.com> <4BAB816F.5060405@firmworks.com>
	<fa686aa41003250916t3d0839e5m42d7f7f6540e821a@mail.gmail.com>
	<4BAB9120.1060600@freescale.com>
	<fa686aa41003250959v401d14e0g151aa54a57eea39@mail.gmail.com>
	<4BAB9755.2080408@freescale.com>
	<fa686aa41003251035h3574a2bahce183ca6056e5f7e@mail.gmail.com>
	<4BABBF54.3010104@freescale.com> <4BABC1CF.1000306@freescale.com>
From: Grant Likely <grant.likely@secretlab.ca>
Date: Thu, 25 Mar 2010 15:54:11 -0600
Message-ID: <fa686aa41003251454y94f787fva07c5c73fc2d7874@mail.gmail.com>
Subject: Re: [PATCH] powerpc/fsl: add device tree binding for QE firmware
To: Timur Tabi <timur@freescale.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: Scott Wood <scottwood@freescale.com>, Mitch Bradley <wmb@firmworks.com>,
	devicetree-discuss@lists.ozlabs.org, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Mar 25, 2010 at 2:04 PM, Timur Tabi <timur@freescale.com> wrote:
> Scott Wood wrote:
>
>> I don't know that it's strictly necessary in this case -- =A0it looks li=
ke
>> there is a magic number in the firmware blob -- but I don't understand
>> the objection as a matter of principle. =A0These device tree discussions
>> have a tendency to get awfully bikesheddy.
>
> I don't want this discussion, and any binding definitions that come from =
it, to be limited to the specifics of a QE firmware. =A0I want to make sure=
 that any binding that we come up with can be easily extended to any kind o=
f firmware, including firmware that has no headers.
>
> Many companies will distribute their firmware as a generic sequence of by=
tes (no header), and a simple code fragment that demonstrates uploading the=
 binary to the hardware. =A0The license for these files sometimes precludes=
 the option of wrapping that microcode inside or with another binary. =A0Th=
at is, if you want to distribute this firmware, it must be distributed as-i=
s.
>
> Example:
>
> Freescale buys a chip from some vendor and puts the chip on a reference b=
oard. =A0The chip requires some microcode to be uploaded, and the vendor di=
stributes some binary blob and a code snippet. =A0Freescale embeds the code=
 snippet in Linux, and puts the microcode somewhere in flash. =A0The licens=
e for the microcode says, "thou shalt not merge this microcode with any oth=
er binary". =A0Freescale decides, for whatever reason, that putting a heade=
r around the microcode and putting *that* in flash is a violation of the li=
cense, but having U-Boot dynamically embed it into a DTB isn't. =A0Ok, mayb=
e that's a bit ridiculous, but just humor me. =A0In this case, it would use=
ful to have the microcode in its own node with properties describing the mi=
crocode.
>
> Anyway, I may have gone off in the weeds with this discussion.

No, this isn't off in the weeds.  I concede the point of needing to
store firmware in a separate node, but I still don't agree with the
argument that it needs to be anything more than an anonymous named
blob.  The fact that another node references it implicitly defines the
format the blob needs to be in.  If the blob format changes, then in
practice the existing binding is no longer compatible because older
drivers just won't work.  It probably doesn't justify creation of a
new compatible value, but I would handle firmware in a different
format with a different property name to reference it.

g.
