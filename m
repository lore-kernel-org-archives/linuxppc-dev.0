Return-Path: <Tiejun.Chen@windriver.com>
Received: from mail1.windriver.com (mail1.windriver.com [147.11.146.13])
 (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "mail1.windriver.com",
 Issuer "Intel External Basic Issuing CA 3A" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 78B662C008E
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 16 May 2013 16:43:36 +1000 (EST)
Message-ID: <5194800D.3010606@windriver.com>
Date: Thu, 16 May 2013 14:43:25 +0800
From: "tiejun.chen" <tiejun.chen@windriver.com>
MIME-Version: 1.0
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: SATA FSL and upstreaming
References: <1368679657.9603.32.camel@pasglop>
 <1368683156.9603.34.camel@pasglop>
 <6A3DF150A5B70D4F9B66A25E3F7C888D0701C307@039-SN2MPN1-012.039d.mgd.msft.net>
 <3E027F8168735B46AC006B1D0C7BB0020B1E040F@039-SN2MPN1-011.039d.mgd.msft.net>
 <1368684547.9603.38.camel@pasglop> <51947A00.9010504@windriver.com>
 <1368685307.9603.39.camel@pasglop> <51947E35.30808@windriver.com>
 <1368686426.9603.49.camel@pasglop>
In-Reply-To: <1368686426.9603.49.camel@pasglop>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Cc: Xie Shaohui-B21989 <B21989@freescale.com>,
 Liu Qiang-B32616 <B32616@freescale.com>,
 Zang Roy-R61911 <r61911@freescale.com>,
 Fleming Andy-AFLEMING <afleming@freescale.com>,
 Bhushan Bharat-R65777 <R65777@freescale.com>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 05/16/2013 02:40 PM, Benjamin Herrenschmidt wrote:
> On Thu, 2013-05-16 at 14:35 +0800, tiejun.chen wrote:
>> On 05/16/2013 02:21 PM, Benjamin Herrenschmidt wrote:
>>> On Thu, 2013-05-16 at 14:17 +0800, tiejun.chen wrote:
>>>> I think you can use Bharat's RCW, which seems RR_HXAPNSP_0x36, then
>>>> please take
>>>> a look at this:
>>>
>>> Ok, how do I update my RCW to bse Bharat's ?
>>
>>
>> Firstly please check which flash bank is used since we have to know where should
>> be updated RCW.
>>
>> What is SW7[1:4]?
>>
>> Or we have another simple way in u-boot prompt:
>>
>> => md.b ffdf002c
>> ffdf002c: 4f 00 fe 00 39 00 00 00 00 00 00 00 00 00 00 00    O...9...........
>> ...
>
> ffdf002c: 0f 00 fe 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
>
>> This means we're on bank4.
>
> I assume that means bank0 ?

Yes, RCW should be burned to 0xec000000.

In u-boot prompt:

=> loady
## Ready for binary (ymodem) download to 0x01000000 at 115200 bps...
C

Then send that RCW with ymodem in your terminal client.

Tiejun
