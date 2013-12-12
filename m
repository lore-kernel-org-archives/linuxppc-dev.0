Return-Path: <tommusta@gmail.com>
Received: from mail-yh0-x229.google.com (mail-yh0-x229.google.com
 [IPv6:2607:f8b0:4002:c01::229])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com",
 Issuer "Google Internet Authority G2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id C29132C00A3
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 13 Dec 2013 07:33:48 +1100 (EST)
Received: by mail-yh0-f41.google.com with SMTP id f11so799752yha.14
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 12 Dec 2013 12:33:44 -0800 (PST)
Message-ID: <52AA1DA0.80003@gmail.com>
Date: Thu, 12 Dec 2013 14:33:36 -0600
From: Tom Musta <tommusta@gmail.com>
MIME-Version: 1.0
To: Paul Mackerras <paulus@samba.org>
Subject: Re: [V2 PATCH 3/3] powerpc: Fix Unaligned LE Floating Point Loads
 and Stores
References: <1383244738-5986-1-git-send-email-tommusta@gmail.com>
 <1383244738-5986-4-git-send-email-tommusta@gmail.com>
 <20131211035440.GA9399@drongo> <20131211045728.GB9399@drongo>
 <52A9D17E.3000809@gmail.com>
In-Reply-To: <52A9D17E.3000809@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 12/12/2013 9:08 AM, Tom Musta wrote:
> On 12/10/2013 10:57 PM, Paul Mackerras wrote:
>> On Wed, Dec 11, 2013 at 02:54:40PM +1100, Paul Mackerras wrote:
> 
>>> This breaks 32-bit big-endian (as well as making the code longer and
>>> more complex).
>>
>> And in fact none of this code will get executed in little-endian mode
>> anyway, since we still have this in the middle of emulate_step():
>>
>> 	/*
>> 	 * Following cases are for loads and stores, so bail out
>> 	 * if we're in little-endian mode.
>> 	 */
>> 	if (regs->msr & MSR_LE)
>> 		return 0;
>>
>> Paul.
>>
> 
> See patch 1/3 to explain how it becomes relevant in LE.
> 
> I will take another look at the change.
> 

It appears that patch 1/3 never got picked up, even though I thought Ben & I
had worked through that.

And I agree that the code could be simpler.  I will work up a patch to address
these two issues.
