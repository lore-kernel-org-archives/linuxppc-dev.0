Return-Path: <bsingharora@gmail.com>
Received: from mail-pf0-x241.google.com (mail-pf0-x241.google.com
 [IPv6:2607:f8b0:400e:c00::241])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vJDjf2RLxzDq60
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  8 Feb 2017 19:23:02 +1100 (AEDT)
Received: by mail-pf0-x241.google.com with SMTP id y143so11177543pfb.1
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 08 Feb 2017 00:23:02 -0800 (PST)
From: Balbir Singh <bsingharora@gmail.com>
Date: Wed, 8 Feb 2017 13:52:54 +0530
To: Douglas Miller <dougmill@linux.vnet.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH 1/1] powerpc/xmon: Dump memory in native endian format.
Message-ID: <20170208082254.GC17068@localhost.localdomain>
References: <1486474844-9872-1-git-send-email-dougmill@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1486474844-9872-1-git-send-email-dougmill@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Feb 07, 2017 at 07:40:44AM -0600, Douglas Miller wrote:
> Extend dump command to allow display of 2, 4, and 8 byte words in native
> endian format. Also adds dump command for "1 byte words" for the sake
> of symmetry. New commands are:
> 
> 	d1	dump 8 bit values
> 	d2	dump 16 bit values
> 	d4	dump 32 bit values
> 	d8	dump 64 bit values
> 
> Signed-off-by: Douglas Miller <dougmill@linux.vnet.ibm.com>
> ---
>  arch/powerpc/xmon/xmon.c |   65 +++++++++++++++++++++++++++++++++++++++++++--
>  1 files changed, 62 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/powerpc/xmon/xmon.c b/arch/powerpc/xmon/xmon.c
> index 9c0e17c..6249975 100644
> --- a/arch/powerpc/xmon/xmon.c
> +++ b/arch/powerpc/xmon/xmon.c
> @@ -212,6 +212,10 @@ static void xmon_print_symbol(unsigned long address, const char *mid,
>    "\
>    C	checksum\n\
>    d	dump bytes\n\
> +  d1	dump 8 bit values\n\
> +  d2	dump 16 bit values\n\
> +  d4	dump 32 bit values\n\
> +  d8	dump 64 bit values\n\
>    di	dump instructions\n\
>    df	dump float values\n\
>    dd	dump double values\n\
> @@ -2334,9 +2338,49 @@ static void dump_pacas(void)
>  }
>  #endif
>  
> +static void dump_by_size(unsigned long addr, long count, int size)
> +{
> +	unsigned char temp[16];
> +	int i, j;
> +	u64 val;
> +
> +	/*
> +	 * 'count' was aligned 16. If that changes, the following
> +	 * must also change to accommodate other values for 'count'.
> +	 */
> +	for (i = 0; i < count; i += 16, addr += 16) {
> +		printf(REG, addr);
> +
> +		if (mread(addr, temp, 16) != 16) {
> +			printf("Faulted reading %d bytes from 0x"REG"\n", 16, addr);

We have a method of printing a special character for faults.
Please see fault_chars[]

Otherwise looks good

Acked-by: Balbir Singh <bsingharora@gmail.com>
