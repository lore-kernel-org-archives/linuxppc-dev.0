Return-Path: <michael@ellerman.id.au>
Date: Wed, 10 Apr 2013 12:21:08 +1000
From: Michael Ellerman <michael@ellerman.id.au>
To: Li Zhong <zhong@linux.vnet.ibm.com>
Subject: Re: [RFC PATCH powerpc] try secondary hash before BUG in
 kernel_map_linear_page()
Message-ID: <20130410022107.GA15929@concordia>
References: <1361784575.3001.5.camel@ThinkPad-T5421.cn.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1361784575.3001.5.camel@ThinkPad-T5421.cn.ibm.com>
Cc: Paul Mackerras <paulus@samba.org>,
 PowerPC email list <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Feb 25, 2013 at 05:29:35PM +0800, Li Zhong wrote:
> This patch tries to fix following issue when CONFIG_DEBUG_PAGEALLOC
> is enabled:
> 
> [  543.075675] ------------[ cut here ]------------
> [  543.075701] kernel BUG at arch/powerpc/mm/hash_utils_64.c:1239!
> [  543.075714] Oops: Exception in kernel mode, sig: 5 [#1]

So the issue is that kernel_map_linear_page() doesn't try the secondary
hash slot.

> The code is borrowed from that in __hash_page_huge().

It is, and in fact there is another copy in hash_low_64.S - in assembler.

So I think we should at least try and keep ourselves to two
implementations, one in asm and one in C. So can you split it out into a
helper routine called by both kernel_map_linear_page() and
__hash_page_huge() ?

cheers
