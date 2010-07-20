Return-Path: <dave@linux.vnet.ibm.com>
Received: from e32.co.us.ibm.com (e32.co.us.ibm.com [32.97.110.150])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e32.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id A7CCEB70CC
	for <linuxppc-dev@ozlabs.org>; Wed, 21 Jul 2010 05:21:40 +1000 (EST)
Received: from d03relay05.boulder.ibm.com (d03relay05.boulder.ibm.com
	[9.17.195.107])
	by e32.co.us.ibm.com (8.14.4/8.13.1) with ESMTP id o6KJDhm8020026
	for <linuxppc-dev@ozlabs.org>; Tue, 20 Jul 2010 13:13:43 -0600
Received: from d03av01.boulder.ibm.com (d03av01.boulder.ibm.com [9.17.195.167])
	by d03relay05.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	o6KJLMvh039498
	for <linuxppc-dev@ozlabs.org>; Tue, 20 Jul 2010 13:21:27 -0600
Received: from d03av01.boulder.ibm.com (loopback [127.0.0.1])
	by d03av01.boulder.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP
	id o6KJLLht018215
	for <linuxppc-dev@ozlabs.org>; Tue, 20 Jul 2010 13:21:22 -0600
Subject: Re: [PATCH 4/8] v3 Allow memory_block to span multiple memory sections
From: Dave Hansen <dave@linux.vnet.ibm.com>
To: Nathan Fontenot <nfont@austin.ibm.com>
In-Reply-To: <4C451E1C.8070907@austin.ibm.com>
References: <4C451BF5.50304@austin.ibm.com> <4C451E1C.8070907@austin.ibm.com>
Content-Type: text/plain; charset="ANSI_X3.4-1968"
Date: Tue, 20 Jul 2010 12:21:20 -0700
Message-ID: <1279653680.9785.5.camel@nimitz>
Mime-Version: 1.0
Cc: linux-mm@kvack.org, greg@kroah.com, linux-kernel@vger.kernel.org,
	KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 2010-07-19 at 22:55 -0500, Nathan Fontenot wrote:
> +static u32 get_memory_block_size(void)
> +{
> +       u32 block_sz;
> +
> +       block_sz = memory_block_size_bytes();
> +
> +       /* Validate blk_sz is a power of 2 and not less than section size */
> +       if ((block_sz & (block_sz - 1)) || (block_sz < MIN_MEMORY_BLOCK_SIZE))
> +               block_sz = MIN_MEMORY_BLOCK_SIZE;

Is this worth a WARN_ON()?  Seems pretty bogus if someone is returning
funky block sizes.  

-- Dave
