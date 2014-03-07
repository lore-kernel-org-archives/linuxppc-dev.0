Return-Path: <mpe@ellerman.id.au>
Message-ID: <1394153258.21206.1.camel@concordia>
Subject: Re: [PATCH] kexec/powerpc: fix exporting memory limit
From: Michael Ellerman <mpe@ellerman.id.au>
To: Nikita Yushchenko <nyushchenko@dev.rtsoft.ru>
Date: Fri, 07 Mar 2014 11:47:38 +1100
In-Reply-To: <1394115854-11709-1-git-send-email-nyushchenko@dev.rtsoft.ru>
References: <1394115854-11709-1-git-send-email-nyushchenko@dev.rtsoft.ru>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: yadviga@dev.rtsoft.ru, lugovskoy@dev.rtsoft.ru, kexec@lists.infradead.org,
 linux-kernel@vger.kernel.org, Paul Mackerras <paulus@samba.org>,
 Anton Blanchard <anton@samba.org>,
 Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>,
 Hari Bathini <hbathini@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2014-03-06 at 18:24 +0400, Nikita Yushchenko wrote:
> When preparing dump-capturing kernel, kexec userspace tool needs to know
> actual amount of memory used by the running kernel. This may differ from
> extire available DRAM for a couple of reasons. To address this issue,
> kdump kernel support code injects several attributes into device tree that
> are later captured by userspace kexec tool via /proc interface.
> 
> One such attrubute is 'chosen/linux,memory_limit' that is used to pass
> memory limit of the running kernel.
> 
> This was initialized using kernel's 'memory_limit' variable, that is set
> by early init code based on mem= kernel parameter and other reasons.
> 
> But there are cases when memory_limit variable does not contain proper
> information. One such case is when !CONFIG_HIGHMEM kernel runs on system
> with memory large enough not to fit into lowmem.

Why doesn't the !CONFIG_HIGHMEM code update memory_limit to reflect reality.

cheers
