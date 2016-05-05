Return-Path: <bsingharora@gmail.com>
Received: from mail-yw0-x241.google.com (mail-yw0-x241.google.com
 [IPv6:2607:f8b0:4002:c05::241])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3r0mBy3QFDzDqHF
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  5 May 2016 17:05:30 +1000 (AEST)
Received: by mail-yw0-x241.google.com with SMTP id y6so10861685ywe.0
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 05 May 2016 00:05:30 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1462429482-1801-2-git-send-email-oohall@gmail.com>
References: <1462429482-1801-1-git-send-email-oohall@gmail.com>
 <1462429482-1801-2-git-send-email-oohall@gmail.com>
Date: Thu, 5 May 2016 17:05:28 +1000
Message-ID: <CAKTCnznoXKQZLadCNsCQMHsY=uK5mjrcgcCxPXjVFrZTNsgsCA@mail.gmail.com>
Subject: Re: [PATCH 2/2] powerpc/mm: Ensure "special" zones are empty
From: Balbir Singh <bsingharora@gmail.com>
To: "Oliver O'Halloran" <oohall@gmail.com>
Cc: linuxppc-dev@lists.ozlabs.org
Content-Type: text/plain; charset=UTF-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, May 5, 2016 at 4:24 PM, Oliver O'Halloran <oohall@gmail.com> wrote:
> The mm zone mechanism was traditionally used by arch specific code to
> partition memory into allocation zones. However there are several zones
> that are managed by the mm subsystem rather than the architecture. Most
> architectures set the max PFN of these special zones to zero, however on
> powerpc we set them to ~0ul. This, in conjunction with a bug in
> free_area_init_nodes() results in all of system memory being placed
> being placed in ZONE_DEVICE when enabled. Device memory cannot be used
> for regular kernel memory allocations so this will cause a kernel panic at
> boot.
>
> Given the planned addition of more mm managed zones (ZONE_CMA) we should
> aim to be consistent with every other architecture and set the max PFN
> for these zones to zero
>
> Signed-off-by: Oliver O'Halloran <oohall@gmail.com>
> ---
>

Reviewed-by: Balbir Singh <bsingharora@gmail.com>
