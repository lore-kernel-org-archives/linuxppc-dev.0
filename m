Return-Path: <Bruce_Leonard@selinc.com>
Received: from tesla.selinc.com (tesla.selinc.com [12.110.71.2])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "tesla.selinc.com", Issuer "RSA Data Security,
	Inc." (verified OK)) by ozlabs.org (Postfix) with ESMTP id 2A9E6DDDF3
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 24 Jan 2007 19:16:03 +1100 (EST)
In-Reply-To: <000001c73c40$0cbaf120$6405a8c0@absolut>
To: "Russell McGuire" <rmcguire@uwbt.com>
Subject: Re: Who's the maintainer for the freescale MPC8349ITX board?
MIME-Version: 1.0
Message-ID: <OF5DD05CB5.86EA50C0-ON8825726D.002BFA4B-8825726D.002D62FD@selinc.com>
From: Bruce_Leonard@selinc.com
Date: Wed, 24 Jan 2007 00:15:52 -0800
Content-Type: text/plain; charset="US-ASCII"
Cc: timur@freescale.com, linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

"Russell McGuire" <rmcguire@uwbt.com> wrote on 01/19/2007 07:06:56 PM:

> Bruce,
> 
> Did you ever get linux to boot up?
> 
> I am wondering if I am having similar problems on my system, though it 
is
> based on the MPC8360E. Serial port code and clocking is the same between
> these systems, at least it should be.
Russ,

Sorry I took so long to get back to you on this.  I've spent the last 
couple of days trying to reproduce the problems I had bringing this board 
up to see if there really were any issues in the code or if it was just me 
not knowing what the heck I was doing.  Turned out to be the latter, 
naturally.

I can't speak to the 8360, but since it's in the same family I expect the 
differences in this regard are trivial.  I did finally manage to get the 
2.6.19.1 kernel to boot on the MPC8349ITX board using u-boot 1.2.0 (I 
don't know if u-boot 1.1.6-dirty is close enough or not) and the 
mpc8349emitx.dts file in the 2.6.19.1 tree.  Some things to know however 
(which I didn't when I started :O ).  You need to use the '-f' flag with 
the DTC to force it to compile (at least I had to with the version I 
have), otherwise it will error out when it finds no 'chosen' node.  You 
don't need one, u-boot will add a 'chosen' node on the fly.  Also, you 
need to use the '-V 0x10' flag in DTC, otherwise it defaults to making a 
version 3 blob.  u-boot seems unable to parse a version 3 blob and 
therefore can't fill in the properties it needs to for the kernel to boot. 
 So, in the end my command to generate the blob file looked like this:

./dtc -I dts -O dtb -f -V 0x10 mpc8349emitx.dts > 8349.blob

This worked for me, your milage may vary.

See 'ya!

Bruce
