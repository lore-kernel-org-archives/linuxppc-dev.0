Return-Path: <chandan@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3ttgG62mtxzDqH1
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  4 Jan 2017 17:02:54 +1100 (AEDT)
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id
 v045xIvJ146751
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 4 Jan 2017 01:02:51 -0500
Received: from e23smtp01.au.ibm.com (e23smtp01.au.ibm.com [202.81.31.143])
 by mx0b-001b2d01.pphosted.com with ESMTP id 27ruc1r77h-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 04 Jan 2017 01:02:51 -0500
Received: from localhost
 by e23smtp01.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <chandan@linux.vnet.ibm.com>;
 Wed, 4 Jan 2017 16:02:48 +1000
Received: from d23relay08.au.ibm.com (d23relay08.au.ibm.com [9.185.71.33])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id 69C392BB0057
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  4 Jan 2017 17:02:46 +1100 (EST)
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
 by d23relay08.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v0462mIT55967894
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 4 Jan 2017 17:02:48 +1100
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
 by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v0462j4E031972
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 4 Jan 2017 17:02:46 +1100
From: Chandan Rajendra <chandan@linux.vnet.ibm.com>
To: Anton Blanchard <anton@samba.org>
Cc: jack@suse.cz, Michael Ellerman <mpe@ellerman.id.au>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>,
 Stephen Rothwell <sfr@canb.auug.org.au>, axboe@fb.com,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: ext4 filesystem corruption with 4.10-rc2 on ppc64le
Date: Wed, 04 Jan 2017 11:32:42 +0530
In-Reply-To: <20170104161808.5ad7b4fd@kryten>
References: <20170104161808.5ad7b4fd@kryten>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Message-Id: <6085340.JSrffQ0Szo@localhost.localdomain>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wednesday, January 04, 2017 04:18:08 PM Anton Blanchard wrote:
> Hi,
> 
> I'm consistently seeing ext4 filesystem corruption using a mainline
> kernel. It doesn't take much to trigger it - download a ppc64le Ubuntu
> cloud image, boot it in KVM and run:
> 
> sudo apt-get update
> sudo apt-get dist-upgrade
> sudo reboot
> 
> And it never makes it back up, dying with rather severe filesystem
> corruption.

Hi,

The patch at https://patchwork.kernel.org/patch/9488235/ should fix the
bug.

> 
> I've narrowed it down to:
> 
> 64e1c57fa474 ("ext4: Use clean_bdev_aliases() instead of iteration")
> e64855c6cfaa ("fs: Add helper to clean bdev aliases under a bh and use it")
> ce98321bf7d2 ("fs: Remove unmap_underlying_metadata")
> 
> Backing these patches out fixes the issue.
> 
> Anton
> --
> To unsubscribe from this list: send the line "unsubscribe linux-ext4" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

-- 
chandan
