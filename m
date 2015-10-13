Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id BC39C1A07F1
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 14 Oct 2015 09:56:24 +1100 (AEDT)
Message-ID: <1444776984.12197.2.camel@ellerman.id.au>
Subject: Re: [PATCH] scripts/tags.sh: Teach tags about some powerpc macros
From: Michael Ellerman <mpe@ellerman.id.au>
To: Michal Marek <mmarek@suse.com>
Cc: linuxppc-dev@ozlabs.org
Date: Wed, 14 Oct 2015 09:56:24 +1100
In-Reply-To: <561CF100.3070605@suse.com>
References: <1442891295-5222-1-git-send-email-mpe@ellerman.id.au>
 <1444713513.29347.3.camel@ellerman.id.au> <561CF100.3070605@suse.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2015-10-13 at 13:54 +0200, Michal Marek wrote:
> On 2015-10-13 07:18, Michael Ellerman wrote:
> > On Tue, 2015-09-22 at 13:08 +1000, Michael Ellerman wrote:
> >> The IO accessors on powerpc are generated using macro fu, ie. out_be32()
> >> etc. Also there are some debugger related symbols that are macro
> >> generated. Teach scripts/tags.sh about both.
> >>
> >> Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
> >> ---
> >>  scripts/tags.sh | 2 ++
> >>  1 file changed, 2 insertions(+)
> >>
> >> diff --git a/scripts/tags.sh b/scripts/tags.sh
> >> index 8e5aee6d9da2..262889046703 100755
> >> --- a/scripts/tags.sh
> >> +++ b/scripts/tags.sh
> >> @@ -198,6 +198,8 @@ exuberant()
> >>  	--regex-c++='/TASK_PFA_TEST\([^,]*,\s*([^)]*)\)/task_\1/'	\
> >>  	--regex-c++='/TASK_PFA_SET\([^,]*,\s*([^)]*)\)/task_set_\1/'	\
> >>  	--regex-c++='/TASK_PFA_CLEAR\([^,]*,\s*([^)]*)\)/task_clear_\1/'\
> >> +	--regex-c++='/DEF_MMIO_(IN|OUT)_(X|D)\(([^,]*),\s*[^)]*\)/\3/'	\
> >> +	--regex-c++='/DEBUGGER_BOILERPLATE\(([^,]*)\)/\1/'		\
> >>  	--regex-c='/PCI_OP_READ\((\w*).*[1-4]\)/pci_bus_read_config_\1/' \
> >>  	--regex-c='/PCI_OP_WRITE\((\w*).*[1-4]\)/pci_bus_write_config_\1/' \
> >>  	--regex-c='/DEFINE_(MUTEX|SEMAPHORE|SPINLOCK)\((\w*)/\2/v/'	\
> > 
> > 
> > Michal, do you want to take this one or should I ?
> 
> I applied it to kbuild.git#misc.

Thanks.

cheers
