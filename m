Return-Path: <paubert@iram.es>
Received: from gra-vd1.iram.es (gra-vd1.iram.es [150.214.224.250])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 5F7AD67B1F
	for <linuxppc-dev@ozlabs.org>; Thu,  7 Apr 2005 07:19:00 +1000 (EST)
From: Gabriel Paubert <paubert@iram.es>
Date: Wed, 6 Apr 2005 23:18:43 +0200
To: Chris Friesen <cfriesen@nortel.com>
Message-ID: <20050406211843.GA2737@iram.es>
References: <425429BF.1050706@nortel.com>
	<2b5cd7aefbd800842537d00be729d169@freescale.com>
	<42544010.4020105@nortel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <42544010.4020105@nortel.com>
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

On Wed, Apr 06, 2005 at 02:01:20PM -0600, Chris Friesen wrote:
> Kumar Gala wrote:
> >I'm having a similar need (for a different purpose), this post might be 
> >useful:
> >
> >http://gcc.gnu.org/ml/gcc/2005-04/msg00283.html
> 
> Sweet!  My new code is now shorter *and* more efficient:
> 
> static inline unsigned long long getmsr()
> {
> 	unsigned long long val;
>         asm volatile( \
>                 "mfmsr  %L0               \n\t" \
>                 "rldicl %0,%L0,32,32       \n\t" \
>                 "rldicl %L0,%L0,0,32        \n\t" \
>                 : "=r" (val));
> 	return val;
> }
> 
> This results in
> 
> unsigned long long a = asdf3();
> unsigned long long b = asdf3();
> 
> being compiled to
> 
> 	mfmsr  6
> 	rldicl 5,6,32,32
> 	rldicl 6,6,0,32
> 	
> 	mfmsr  8
> 	rldicl 7,8,32,32
> 	rldicl 8,8,0,32

If you are running in 32 bit mode, you don't need
to clear the upper half of %L0. The architecture is 
designed so that pure 32 bit code runs unmodified despite
the fact that you can access the upper 32 bits using
64 bit instructions.

	Regards,
	Gabriel
