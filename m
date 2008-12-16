Return-Path: <ahuja@austin.ibm.com>
Received: from e31.co.us.ibm.com (e31.co.us.ibm.com [32.97.110.149])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e31.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 76336DDF2B
	for <linuxppc-dev@ozlabs.org>; Wed, 17 Dec 2008 09:18:26 +1100 (EST)
Received: from d03relay02.boulder.ibm.com (d03relay02.boulder.ibm.com
	[9.17.195.227])
	by e31.co.us.ibm.com (8.13.1/8.13.1) with ESMTP id mBGMGwr7021548
	for <linuxppc-dev@ozlabs.org>; Tue, 16 Dec 2008 15:16:58 -0700
Received: from d03av01.boulder.ibm.com (d03av01.boulder.ibm.com [9.17.195.167])
	by d03relay02.boulder.ibm.com (8.13.8/8.13.8/NCO v9.1) with ESMTP id
	mBGMINxg206196
	for <linuxppc-dev@ozlabs.org>; Tue, 16 Dec 2008 15:18:23 -0700
Received: from d03av01.boulder.ibm.com (loopback [127.0.0.1])
	by d03av01.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	mBGMINQ6017306
	for <linuxppc-dev@ozlabs.org>; Tue, 16 Dec 2008 15:18:23 -0700
Message-ID: <4948292F.8080402@austin.ibm.com>
Date: Tue, 16 Dec 2008 16:18:23 -0600
From: Manish Ahuja <ahuja@austin.ibm.com>
MIME-Version: 1.0
To: Paul Mackerras <paulus@samba.org>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	Manish Ahuja <mahuja@us.ibm.com>, LinuxPPC-dev <linuxppc-dev@ozlabs.org>
Subject: Re: [PATCH] Protect against NULL pointer deref in phyp-dump code.
References: <20081216041748.GB14890@ozlabs.org>
In-Reply-To: <20081216041748.GB14890@ozlabs.org>
Content-Type: text/plain; charset=ISO-8859-1
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


Acked-by: Manish Ahuja <mahujam@gmail.com>


Tony Breeds wrote:
> print_dump_header() will be called at least once with a NULL pointer in
> a normal boot sequence.  if DEBUG is defined then we will get a deref,
> add a quick fix to exit early in the NULL pointer case.
> 
> Signed-off-by: Tony Breeds <tony@bakeyournoodle.com>
> ---
>  arch/powerpc/platforms/pseries/phyp_dump.c |    3 +++
>  1 files changed, 3 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/powerpc/platforms/pseries/phyp_dump.c b/arch/powerpc/platforms/pseries/phyp_dump.c
> index edbc012..16e659a 100644
> --- a/arch/powerpc/platforms/pseries/phyp_dump.c
> +++ b/arch/powerpc/platforms/pseries/phyp_dump.c
> @@ -130,6 +130,9 @@ static unsigned long init_dump_header(struct phyp_dump_header *ph)
>  static void print_dump_header(const struct phyp_dump_header *ph)
>  {
>  #ifdef DEBUG
> +	if (ph == NULL)
> +		return;
> +
>  	printk(KERN_INFO "dump header:\n");
>  	/* setup some ph->sections required */
>  	printk(KERN_INFO "version = %d\n", ph->version);


-- 

--
Manish Ahuja
Linux RAS Engineer.
IBM Linux Technology Center
mahuja@us.ibm.com
512-838-1928, t/l 678-1928.
