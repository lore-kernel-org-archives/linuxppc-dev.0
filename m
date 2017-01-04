Return-Path: <prvs=217711bd88=axboe@fb.com>
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com
 [67.231.145.42])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3ttvrw4tY4zDqJr
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  5 Jan 2017 02:30:24 +1100 (AEDT)
Subject: Re: ext4 filesystem corruption with 4.10-rc2 on ppc64le
To: Anton Blanchard <anton@samba.org>, <jack@suse.cz>, Michael Ellerman
 <mpe@ellerman.id.au>, Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 "Paul Mackerras" <paulus@samba.org>,
 Stephen Rothwell <sfr@canb.auug.org.au>
References: <20170104161808.5ad7b4fd@kryten>
CC: <linuxppc-dev@lists.ozlabs.org>, <linux-kernel@vger.kernel.org>,
 <linux-ext4@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>
From: Jens Axboe <axboe@fb.com>
Message-ID: <ab00525e-50d6-de22-c83c-992985297309@fb.com>
Date: Wed, 4 Jan 2017 08:09:28 -0700
MIME-Version: 1.0
In-Reply-To: <20170104161808.5ad7b4fd@kryten>
Content-Type: text/plain; charset="windows-1252"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 01/03/2017 10:18 PM, Anton Blanchard wrote:
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
> 
> I've narrowed it down to:
> 
> 64e1c57fa474 ("ext4: Use clean_bdev_aliases() instead of iteration")
> e64855c6cfaa ("fs: Add helper to clean bdev aliases under a bh and use it")
> ce98321bf7d2 ("fs: Remove unmap_underlying_metadata")
> 
> Backing these patches out fixes the issue.

Fix is going out today, I see Chandan already pointed you at it. For the
other reporter, it's not an LE vs BE thing, it's a fs blocksize < page
size problem.

-- 
Jens Axboe
