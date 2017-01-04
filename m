Return-Path: <anton@samba.org>
Received: from hr2.samba.org (hr2.samba.org [IPv6:2a01:4f8:192:486::147:1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3ttfGv0LtVzDqR0
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  4 Jan 2017 16:18:31 +1100 (AEDT)
Date: Wed, 4 Jan 2017 16:18:08 +1100
From: Anton Blanchard <anton@samba.org>
To: jack@suse.cz, Michael Ellerman <mpe@ellerman.id.au>, Benjamin
 Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras
 <paulus@samba.org>, Stephen Rothwell <sfr@canb.auug.org.au>, axboe@fb.com
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: ext4 filesystem corruption with 4.10-rc2 on ppc64le
Message-ID: <20170104161808.5ad7b4fd@kryten>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi,

I'm consistently seeing ext4 filesystem corruption using a mainline
kernel. It doesn't take much to trigger it - download a ppc64le Ubuntu
cloud image, boot it in KVM and run:

sudo apt-get update
sudo apt-get dist-upgrade
sudo reboot

And it never makes it back up, dying with rather severe filesystem
corruption.

I've narrowed it down to:

64e1c57fa474 ("ext4: Use clean_bdev_aliases() instead of iteration")
e64855c6cfaa ("fs: Add helper to clean bdev aliases under a bh and use it")
ce98321bf7d2 ("fs: Remove unmap_underlying_metadata")

Backing these patches out fixes the issue.

Anton
