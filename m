Return-Path: <aldo.lab@gmail.com>
Received: from nf-out-0910.google.com (nf-out-0910.google.com [64.233.182.184])
	by ozlabs.org (Postfix) with ESMTP id 2462567BCE
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 16 Nov 2006 20:22:52 +1100 (EST)
Received: by nf-out-0910.google.com with SMTP id n15so863200nfc
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 16 Nov 2006 01:22:51 -0800 (PST)
Message-ID: <6e41d1460611160122u4f8163a1t4ba127ec8815067f@mail.gmail.com>
Date: Thu, 16 Nov 2006 10:22:50 +0100
From: "aldo lab" <aldo.lab@gmail.com>
To: "Dan Malek" <dan@embeddedalley.com>
Subject: Re: Performance on PowerQuicc8280 linux based
In-Reply-To: <F1EB2EA4-DF62-4825-84CF-C9E5497AEB09@embeddedalley.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
References: <6e41d1460611150654j6e532ae1pbe378685539e257e@mail.gmail.com>
	<455B3E84.8010606@mock.com>
	<F1EB2EA4-DF62-4825-84CF-C9E5497AEB09@embeddedalley.com>
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

If I remove the changes I'm not available to reach the previous
result, and to perform the test I use an external traffic generator (
Smartbit) and this has an hight precision.
So the problem in some way should be tied to cache but I don't know
what I can try.I blocked some critical function (in term of cpu
cycles)  in istruction cache but I didn't obtained a good result
Let me know if you have some idea

Thanks
Aldo


On 11/15/06, Dan Malek <dan@embeddedalley.com> wrote:
>
> On Nov 15, 2006, at 11:21 AM, Jeff Mock wrote:
>
> > I'm no big help, but the problem might be TLB related instead of cache
> > related.  The performance of embedded PPCs with small TLBs requiring
> > software assist for TLB misses can be performance sensitive to TLB
> > misses.
>
> The 82xx is fully cache coherent and has BATs for
> mapping the kernel space.  This is not a PPC with
> a small TLB, but rather one of the most efficient.
> The TLBs are not an issue,  and I doubt the caches
> are as well.
>
> I don't know what kind of test is used to measure this
> performance, but the first thing you must always scrutinize
> are your testing methods and procedures.  Just using
> a user application to measure network performance
> enables a large number of variables that must be
> properly understood and controlled.  Some other
> thread could have switched in and stolen CPU cycles,
> you could have some sampling rate and time
> measurement hysteresis due to buffering,
> you need to find and control such things.
>
> Can you "undo" the changes and get the old
> results?  That's the first thing I would verify,
> and then verify the results are repeatable.
> If that's the case, I'd carefully try to understand
> what this "unrelated" change really affects
> in terms of using CPU cycles.
>
> Thanks.
>
>        -- Dan
>
>
