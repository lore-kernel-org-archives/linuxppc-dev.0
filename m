Return-Path: <paulus@ozlabs.org>
Date: Tue, 21 May 2013 18:10:31 +1000
From: Paul Mackerras <paulus@samba.org>
To: Chen Gang <gang.chen@asianux.com>
Subject: Re: [PATCH] PowerPC: kernel: need return the related error code when
 failure occurs.
Message-ID: <20130521081031.GA29303@iris.ozlabs.ibm.com>
References: <519B0ACA.6090008@asianux.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <519B0ACA.6090008@asianux.com>
Cc: Arnd Bergmann <arnd@arndb.de>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 zhangyanfei@cn.fujitsu.com, Jiri Kosina <jkosina@suse.cz>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, May 21, 2013 at 01:48:58PM +0800, Chen Gang wrote:
> 
> When error occurs, need return the related error code to let upper
> caller know about it.
> 
> ppc_md.nvram_size() can return the error code (e.g. core99_nvram_size()
> in 'arch/powerpc/platforms/powermac/nvram.c').
> 
> And when '*ppos >= size', need return -ESPIPE (Illegal seek)

Why?  When *ppos >= size, it should return 0 (end of file) in my opinion.
ESPIPE means that any seek would be ineffective, not that a particular
seek went out of bounds.

Paul.
