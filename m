Return-Path: <scottwood@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 5855ADDDA0
	for <linuxppc-dev@ozlabs.org>; Tue, 31 Mar 2009 06:33:00 +1100 (EST)
Message-ID: <49D11E47.8080106@freescale.com>
Date: Mon, 30 Mar 2009 14:32:23 -0500
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: Joakim Tjernlund <Joakim.Tjernlund@transmode.se>
Subject: Re: [PATCH] ucc_geth: Rework the TX logic.
References: <1238089445-28396-1-git-send-email-Joakim.Tjernlund@transmode.se>	<2a27d3730903270245k6e8633eehfb5cd3fcebd36240@mail.gmail.com>
	<OFDCE90357.0EDC5DC1-ONC1257586.003759A3-C1257586.00390AD3@transmode.se>
	<49CCD3E8.9040007@freescale.com>
	<OFEFCEAFB5.CC21FFBB-ONC1257589.005AEF16-C1257589.005B64EB@transmode.se>
	<49D0FFBB.7000009@freescale.com>
	<OF3127420C.081D4097-ONC1257589.00603E3D-C1257589.006093B3@transmode.se>
	<49D1052D.2050609@freescale.com>
	<OF70832E04.3DC53F05-ONC1257589.00663AFF-C1257589.0066C397@transmode.se>
In-Reply-To: <OF70832E04.3DC53F05-ONC1257589.00663AFF-C1257589.0066C397@transmode.se>
Content-Type: text/plain; charset=UTF-8; format=flowed
Cc: linuxppc-dev@ozlabs.org, Li Yang <leoli@freescale.com>, pku.leo@gmail.com,
	netdev@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Joakim Tjernlund wrote:
>> different since descriptors are in MURAM which is ioremap()ed -- though 
>> switching to a cacheable mapping with barriers should be a performance 
>> improvement.
> 
> I always thought that MURAM was very fast. The whole reason to have BDs in
> MURAM is that it is faster than normal RAM, at least that is what I 
> thought.

Yeah, on second thought it probably wouldn't be worth it.  There's also 
the question of under what circumstances the QE's MURAM accesses will be 
cache-coherent.

As for the CPU not reordering guarded+cache inhibited accesses, that 
initially seemed to be true for the new arch stuff (book3e/book3s, but 
not really, see below), but the classic arch documentation only 
guarantees stores to such regions to be in-order (and the 
explicitly-specified operation of eieio on I+G accesses wouldn't make 
much sense if they were already guaranteed to be in-order).

Then I looked at the EREF to see what older book E documents had to say 
on the issue, and it suggests that when the architecture document says 
"out of order", it really means "speculative" (and reading the arch 
doc's definition of "out of order" seems to confirm this -- redefining 
terms is bad, m'kay?).  So it seems that the simple answer is no, 
guarded storage is not guaranteed to be in order, unless the only thing 
that can cause an out-of-order access is speculative execution.

-Scott
