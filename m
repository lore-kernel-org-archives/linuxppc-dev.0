Return-Path: <mathieu.malaterre@gmail.com>
Received: from mail-wm0-x231.google.com (mail-wm0-x231.google.com
 [IPv6:2a00:1450:400c:c09::231])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 402jH04FjbzF09b
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 16 Mar 2018 22:02:52 +1100 (AEDT)
Received: by mail-wm0-x231.google.com with SMTP id h76so2273129wme.4
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 16 Mar 2018 04:02:52 -0700 (PDT)
Sender: Mathieu Malaterre <mathieu.malaterre@gmail.com>
From: Mathieu Malaterre <malat@debian.org>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, linuxppc-dev@lists.ozlabs.org,
 Mathieu Malaterre <malat@debian.org>
Subject: [PATCH 00/19] Start using __printf attribute (single commit series)
Date: Fri, 16 Mar 2018 12:02:05 +0100
Message-Id: <20180316110224.12260-1-malat@debian.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This series is part of my warning fixes branch. When preparing the patch, I
figured that sending it as single patch would make the reviewing task fairly
difficult. I decided to split it into fake commits and group them by warning
types to make reviewing much easier. Obviously this series is not meant to be
applied as-is but squashed into a single commit (maybe two if I move the gcc
attribute as second patch). I saw that my previous patches were applied with a
trimmed warning context to reduce the level of noise, I'll keep that in mind
when preparing the squashed commit.

This series has only been compiled tested using ppc32_defconfig and
ppc64_defconfig, hopefully those two cover all combinations for this piece of
code. I am not sure what (if anything?) I am going to break when replacing
%016lx with %p on 32 bits arch, the other changes seems more direct. I am open
for suggestion for the last commit (maybe combine the two function-like macros
DUMP & DUMPPTR into a single one with an extra parameter).

Mathieu Malaterre (19):
  xmon: Use __printf markup to silence compiler
  ppc32: change %x into %lx
  ppc32: Change %.16x into %p
  ppc32: change %lx into %p
  ppc32: change %lx into %tx (ptrdiff_t)
  ppc64: change %lx into %llx
  ppc64: change %ld into %d
  ppc64: change %x into %lx
  ppc64: change %016lx into %p
  ppc64: change %lx into %p
  ppc64: change %lx into %x
  ppc64: change %lx into %llx
  ppc64: change %llx into %lx
  ppc64: change %p into %llx
  ppc64: change %d into %ld
  ppc64: Change %d into %lu
  ppc64: change %d into %llu
  ppc64: change %ld into %d
  ppc64: Handle %p format in DUMPPTR() function-like macro

 arch/powerpc/include/asm/xmon.h |   2 +-
 arch/powerpc/xmon/nonstdio.h    |   8 +--
 arch/powerpc/xmon/spu-dis.c     |  18 +++---
 arch/powerpc/xmon/xmon.c        | 133 ++++++++++++++++++++--------------------
 4 files changed, 82 insertions(+), 79 deletions(-)

-- 
2.11.0
