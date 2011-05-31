Return-Path: <whitebox@nefkom.net>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.10])
	by ozlabs.org (Postfix) with ESMTP id EDB15B6F75
	for <linuxppc-dev@ozlabs.org>; Wed,  1 Jun 2011 03:32:54 +1000 (EST)
From: Andreas Schwab <schwab@linux-m68k.org>
To: Larry Finger <Larry.Finger@lwfinger.net>
Subject: Re: [PATCH] ssb: pci: implement serdes workaround
References: <1301657212-12126-1-git-send-email-zajec5@gmail.com>
	<m2vcwr9pn8.fsf@linux-m68k.org> <4DE505C6.8020601@lwfinger.net>
	<m3wrh6hnmn.fsf@linux-m68k.org> <4DE51487.1000808@lwfinger.net>
	<m239jukddk.fsf@igel.home>
Date: Tue, 31 May 2011 19:32:50 +0200
In-Reply-To: <m239jukddk.fsf@igel.home> (Andreas Schwab's message of "Tue, 31
	May 2011 19:07:19 +0200")
Message-ID: <m2vcwqixml.fsf@igel.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: =?utf-8?Q?Rafa=C5=82_Mi=C5=82ecki?=
	<public-zajec5-Re5JQEeQqe8AvxtiuMwx3w@plane.gmane.org>,
	Michael =?utf-8?Q?B=C3=BCsch?=
	<public-mb-fseUSCV1ubazQB+pC5nmwQ@plane.gmane.org>,
	public-b43-dev-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@plane.gmane.org,
	linuxppc-dev@ozlabs.org, "John W.
	Linville" <public-linville-2XuSBdqkA4R54TAoqtyWWQ@plane.gmane.org>,
	public-linux-wireless-u79uwXL29TY76Z2rM5mHXA@plane.gmane.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Andreas Schwab <schwab@linux-m68k.org> writes:

> Larry Finger <Larry.Finger@lwfinger.net> writes:
>
>> On 05/31/2011 10:54 AM, Andreas Schwab wrote:
>>> Larry Finger<Larry.Finger@lwfinger.net>  writes:
>>>
>>>>  From the traceback, it must be the serdes_pll_device read that failed.
>>>
>>> Why not ssb_pcicore_polarity_workaround (note r4 == 0x134)?
>>
>> Mainly because the last two steps in the traceback are
>>
>> [c2ca5c40] [f2146244] ssb_pcie_read+0x4c/0x54 [ssb]
>> [c2ca5c50] [f2146440] ssb_pcicore_serdes_workaround+0x1c/0x170 [ssb]
>
> Which exactly is what ssb_pcicore_polarity_workaround is doing.

0000022c <ssb_pcicore_serdes_workaround>:
 22c:   94 21 ff e0     stwu    r1,-32(r1)
 230:   7c 08 02 a6     mflr    r0
 234:   38 80 02 04     li      r4,516
 238:   90 01 00 24     stw     r0,36(r1)
 23c:   bf a1 00 14     stmw    r29,20(r1)
 240:   7c 7f 1b 78     mr      r31,r3
 244:   4b ff fd bd     bl      0 <ssb_pcie_read>

Andreas.

-- 
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
