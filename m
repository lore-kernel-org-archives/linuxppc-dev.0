Return-Path: <kumar.gala@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103]) by ozlabs.org (Postfix) with ESMTP id B09F467A6D
	for <linuxppc-dev@ozlabs.org>; Thu,  7 Apr 2005 05:16:22 +1000 (EST)
In-Reply-To: <425429BF.1050706@nortel.com>
References: <425429BF.1050706@nortel.com>
Mime-Version: 1.0 (Apple Message framework v619.2)
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Message-Id: <2b5cd7aefbd800842537d00be729d169@freescale.com>
From: Kumar Gala <kumar.gala@freescale.com>
Date: Wed, 6 Apr 2005 14:16:15 -0500
To: "Chris Friesen" <cfriesen@nortel.com>
Cc: linuxppc-dev@ozlabs.org
Subject: Re: question on inline assembly and long long values
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

I'm having a similar need (for a different purpose), this post might be=20=

useful:

http://gcc.gnu.org/ml/gcc/2005-04/msg00283.html

- kumar

On Apr 6, 2005, at 1:26 PM, Chris Friesen wrote:

> I want to retrieve the msr (which is 64-bits) on a 970 when running in
> 32-bit mode.=A0 I have the following bit of code that seems to work, =
but
> when looking at the code it always seems to use a suboptimal register
> for the low word, and then it ends up having to copy it to the right
> register to create a long long register pair.
>
> static inline unsigned long long get_msr()
>  {
>  =A0=A0=A0=A0=A0=A0=A0 union {
>  =A0=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 struct {
>  =A0=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 =
unsigned long low;
>  =A0=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 =
unsigned long high;
>  =A0=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 } words;
>  =A0=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 unsigned long long val;
>  =A0=A0=A0=A0=A0=A0=A0 } val;
>  =A0=A0=A0=A0=A0=A0=A0=A0 asm volatile( \
>  =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 "mfmsr=A0 =
%0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 \n\t" \
>  =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 "rldicl =
%1,%0,32,32=A0=A0=A0=A0=A0=A0 \n\t" \
>  =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 "rldicl =
%0,%0,0,32=A0=A0=A0=A0=A0=A0=A0 \n\t" \
>  =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 : "=3Dr" =
(val.words.low), "=3Dr" (val.words.high));
> =A0=A0=A0=A0=A0=A0=A0 return val.val;
>  }
>
> Using this code, the optimised assembly output of
>
> =A0=A0=A0=A0=A0=A0=A0 unsigned long long a =3D asdf();
>  =A0=A0=A0=A0=A0=A0=A0 unsigned long long b =3D asdf();
>
> is
>
> =A0=A0=A0=A0=A0=A0=A0 mfmsr=A0 5
>  =A0=A0=A0=A0=A0=A0=A0 rldicl 0,5,32,32
>  =A0=A0=A0=A0=A0=A0=A0 rldicl 5,5,0,32
>  =A0=A0=A0=A0=A0=A0=A0 mr 6,0
>  =A0=A0=A0=A0=A0=A0=A0 mfmsr=A0 7
>  =A0=A0=A0=A0=A0=A0=A0 rldicl 9,7,32,32
>  =A0=A0=A0=A0=A0=A0=A0 rldicl 7,7,0,32
>  =A0=A0=A0=A0=A0=A0=A0 mr 8,9
>
> I figure it should have been able to use registers 6/8 in the first
> place, and save the extra moves.
>
> Is there any way to help gcc optimise this?
>
>
>
> Chris
>  _______________________________________________
> Linuxppc-dev mailing list
>  Linuxppc-dev@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-dev
