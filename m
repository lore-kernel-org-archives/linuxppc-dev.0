Return-Path: <dhowells@redhat.com>
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
	by ozlabs.org (Postfix) with ESMTP id C7F26B70A8
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 27 Jul 2010 05:42:07 +1000 (EST)
From: David Howells <dhowells@redhat.com>
In-Reply-To: <AANLkTikJJYRP=5yPQ8dG9ofXz3HvWzfQU2kt4PDui7EF@mail.gmail.com>
References: <AANLkTikJJYRP=5yPQ8dG9ofXz3HvWzfQU2kt4PDui7EF@mail.gmail.com>
To: Ravi Gupta <dceravigupta@gmail.com>
Subject: Re: Memory Mapping a char array in User Space
Date: Mon, 26 Jul 2010 20:42:01 +0100
Message-ID: <918.1280173321@redhat.com>
Sender: dhowells@redhat.com
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Ravi Gupta <dceravigupta@gmail.com> wrote:

> My device gets memory map successfully but when I tried to read from it
> I get garbage value. Is there something that I am missing?

For starters, you really should allocate a page for your buffer rather than
using kernel static data.  mmap() allows access to page-aligned data through
multiple-of-page-sized holes only[*].  Not only that, your kernel static map
buffer may not necessarily have a struct page covering it, in which case
virt_to_page() may not give you anything useful.

Furthermore, I don't think *you* should be calling remap_pfn_range().
I think you should be leaving the mapping to the core VM routines.

David

[*] unless your kernel is CONFIG_MMU=n
