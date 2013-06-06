Return-Path: <anton@samba.org>
Date: Thu, 6 Jun 2013 13:01:05 +1000
From: Anton Blanchard <anton@samba.org>
To: Michael Neuling <mikey@neuling.org>
Subject: Re: [PATCH 5/5] net: Block MSG_CMSG_COMPAT in send(m)msg and
 recv(m)msg
Message-ID: <20130606130105.6e51066f@kryten>
In-Reply-To: <CAEjGV6xcF776C6N6VxeMY0Vyk+X51oNixdbN42-xkWjQOaMEQA@mail.gmail.com>
References: <cover.1369177867.git.luto@amacapital.net>
 <aa015609319786835bcab445d507faa75c11f111.1369177867.git.luto@amacapital.net>
 <CAEjGV6xcF776C6N6VxeMY0Vyk+X51oNixdbN42-xkWjQOaMEQA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: netdev@vger.kernel.org, x86@kernel.org, linux-kernel@vger.kernel.org,
 Andy Lutomirski <luto@amacapital.net>, Linux PPC dev <linuxppc-dev@ozlabs.org>,
 trinity@vger.kernel.org, torvalds@linux-foundation.org, "David S.
 Miller" <davem@davemloft.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi,

> This is causing a regression on 64bit powerpc with 32bit usermode.
> When I hit userspace, udev is broken and I suspect all networking is
> broken as well.
> 
> Can we please revert 1be374a0518a288147c6a7398792583200a67261
> upstream?
> 
> Found via bisect.

Doesn't this patch break compat_sys_sendmsg and compat_sys_recvmsg?
We'd need to move the guts of sys_* into compat_sys_* to fix it.

Anton
