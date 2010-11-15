Return-Path: <timur.tabi@gmail.com>
Received: from mail-iw0-f179.google.com (mail-iw0-f179.google.com
	[209.85.214.179]) by ozlabs.org (Postfix) with ESMTP id 8E96CB7105
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 16 Nov 2010 03:14:34 +1100 (EST)
Received: by iwn2 with SMTP id 2so7290598iwn.38
	for <linuxppc-dev@lists.ozlabs.org>;
	Mon, 15 Nov 2010 08:14:32 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <3B38AD35-39A2-4A54-8109-65D6DE436227@kernel.crashing.org>
References: <1289477789-10651-1-git-send-email-leoli@freescale.com>
	<54AAF9B7-9533-45B8-9C49-A964203AF707@kernel.crashing.org>
	<AANLkTi=1nutREorMFY2VJyUYQD0SHfiSeskw-u22P+R-@mail.gmail.com>
	<3B38AD35-39A2-4A54-8109-65D6DE436227@kernel.crashing.org>
From: Timur Tabi <timur.tabi@gmail.com>
Date: Mon, 15 Nov 2010 10:13:58 -0600
Message-ID: <AANLkTin8+13mr-tV-2iCG+zGRfF6xZ23cN+=44dsaQor@mail.gmail.com>
Subject: Re: [PATCH v2] fsldma: add support to 36-bit physical address
To: Kumar Gala <galak@kernel.crashing.org>
Content-Type: text/plain; charset=ISO-8859-1
Cc: dan.j.williams@intel.com, linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Nov 15, 2010 at 9:16 AM, Kumar Gala <galak@kernel.crashing.org> wro=
te:

> The programming model (if you look at the free-space in the registers and=
 data structures) supports a 64-bit address. =A0I'm trying to avoid changin=
g the driver in the future if we have >36-bit. =A0However this is such a mi=
nor worry that I'll stop and just ack the patch as is.

I must still be missing something.  I'm looking at the description of
the SATR register in the MPC8572 RM, and it shows this:

0 - 3 |   4 - 5   |     6     |   7  |   8 - 11  |   12 - 15  | 16-21 | 22-=
31
 ---  | STFLOWLVL | SPCIORDER | SSME | STRANSINT | SREADTTYPE |  ---  |  ES=
AD

The most that we can extend ESAD to is 16 bits, for a total of a
48-bit physical address.  Where are the other 16 bits supposed to go?

--=20
Timur Tabi
Linux kernel developer at Freescale
