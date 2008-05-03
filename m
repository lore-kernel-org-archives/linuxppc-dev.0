Return-Path: <kevdig@hypersurf.com>
Received: from smtpauth.hypersurf.com (smtpauth.hypersurf.com [209.237.0.8])
	by ozlabs.org (Postfix) with ESMTP id A219BDDDFB
	for <linuxppc-dev@ozlabs.org>; Sat,  3 May 2008 14:59:19 +1000 (EST)
Received: from [192.168.1.37] (node77.73.251.72.1dial.com [72.251.73.77])
	(authenticated bits=0)
	by smtpauth.hypersurf.com (8.14.2/8.14.2) with ESMTP id m434vhm3083971
	for <linuxppc-dev@ozlabs.org>; Fri, 2 May 2008 21:59:09 -0700 (PDT)
Message-ID: <481BFBF6.9060700@hypersurf.com>
Date: Fri, 02 May 2008 22:45:26 -0700
From: Kevin Diggs <kevdig@hypersurf.com>
MIME-Version: 1.0
To: linuxppc-dev@ozlabs.org
Subject: Re: function calls from identify_cpu()
References: <481B7CB4.90103@hypersurf.com> <1209770980.26383.18.camel@pasglop>
In-Reply-To: <1209770980.26383.18.camel@pasglop>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Benjamin Herrenschmidt wrote:
> On Fri, 2008-05-02 at 13:42 -0700, Kevin Diggs wrote:
> 
>>I added:
>>
>>int __init iDoNothingUseful(struct cpu_spec *s,struct cpu_spec *t)
>>{
>>         return s-t;
>>}
>>
>>right before the definition of identify_cpu() in cputable.c and:
>>
>>//                      (void) (*PTRRELOC(&iDoNothingUseful))(s,t);
>>                         (void) iDoNothingUseful(s,t);
>>
>>right before the return s; in the match block and it will not boot? Can 
>>someone please explain what might be going on?
> 
> 
> Why are you trying to muck around with that code in the first
> place ? :-)
> 
> What are you trying to achieve ?
> 
> Cheers,
> Ben.
> 
The original intent was to find a way to add some of the PLL parameters 
(min and max core frequencies, min and max bus ratios - FX 400 - 800, 2 
- 20; GX 500 - 1000, 2 - 20). Initially it seemed like the place to put 
them. To avoid kernel bloat I think I'll just put them in the init 
routine of the driver. I'll have to redo the cpu detection (FX vs GX); 
but I guess that is not that big of a deal.

But now it is about retaining what is left of my sanity. I took the 
above code and added it to a GigE running the same installation (the 
8600 installation was created by installing its disk in the GigE) and it 
ran fine!?! ANY suggestions would be greatly appreciated. Something to 
do with BootX? BootX is to old (1.2.4)? System needs an exorcism? I 
screwed up something in the 750GX cpu_spec entry?

Both are running 2.6.24.

kevin

P.S.:  I would still appreciate it if someone could explain why this line:

*PTRRELOC(&cur_cpu_spec) = &the_cpu_spec;

isn't:

*PTRRELOC((&cur_cpu_spec) = PTRRELOC(&the_cpu_spec);

Is the address &the_cpu_spec valid later in the kernel initialization? 
Is it ... valid now?
