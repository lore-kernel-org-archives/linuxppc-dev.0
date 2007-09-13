Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 50F7EDE7FC
	for <linuxppc-dev@ozlabs.org>; Fri, 14 Sep 2007 07:12:19 +1000 (EST)
In-Reply-To: <20070913160539.GA32696@ld0162-tx32.am.freescale.net>
References: <20070905192924.GI32462@ld0162-tx32.am.freescale.net>
	<9BC5B02A-4E9D-42DD-90C3-F8C3382F2A96@kernel.crashing.org>
	<20070913160539.GA32696@ld0162-tx32.am.freescale.net>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <E7B70993-BC1A-4DB1-9497-D2D8994AB366@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH 10/10] mpc82xx: Add pq2fads board support.
Date: Thu, 13 Sep 2007 16:15:10 -0500
To: Scott Wood <scottwood@freescale.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Sep 13, 2007, at 11:05 AM, Scott Wood wrote:

> On Thu, Sep 13, 2007 at 01:39:58AM -0500, Kumar Gala wrote:
>>> +	CS: chipselect {
>>
>> We need to document this in booting-without-of.
>
> OK.

cool.  Want to make sure we can encompass the 83xx/85xx/86xx local  
bus in there.

>>> +		PIC: interrupt-controller@10c00 {
>>> +			#interrupt-cells = <2>;
>>> +			interrupt-controller;
>>> +			reg = <10c00 80>;
>>> +			compatible = "fsl,mpc8280-pic", "fsl,pq2-pic";
>>
>> this should also have a "fsl,cpm2-pic" or something of that form.
>> (exact same pic exists on 8560, 85xx+CPM)
>
> OK...  I did it as pq2 rather than cpm2 because IIRC it wasn't  
> described
> under the CPM section of the manual, so I didn't know if 85xx CPM2 had
> the same thing.

No problem.  The cpm2_* code in the kernel is used on 85xx's that  
have a CPM and I don't think we have that much ifdef for 85xx  
specific CPM foo.  Only thing I can think of is this bit in cpm2.h:

#if defined(CONFIG_8272) || defined(CONFIG_MPC8555)
#define CPM_DATAONLY_SIZE       ((uint)(8 * 1024) - CPM_DATAONLY_BASE)
#define CPM_FCC_SPECIAL_BASE    ((uint)0x00009000)
#else

- k
