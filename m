Return-Path: <olof@lixom.net>
Received: from mail.lixom.net (lixom.net [66.141.50.11])
	by ozlabs.org (Postfix) with ESMTP id 7699067A66
	for <linuxppc-dev@ozlabs.org>; Fri, 30 Jun 2006 07:29:02 +1000 (EST)
Date: Thu, 29 Jun 2006 14:27:57 -0700
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH] powerpc: support ibm,extended-*-frequency properties
Message-ID: <20060629212757.GA5093@pb15.lixom.net>
References: <20060620084726.GC30974@krispykreme>
	<0107ED1F-B674-48C3-AA07-BDF9FD2F7678@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <0107ED1F-B674-48C3-AA07-BDF9FD2F7678@kernel.crashing.org>
From: Olof Johansson <olof@lixom.net>
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org,
	Anton Blanchard <anton@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, Jun 27, 2006 at 11:48:57PM -0500, Kumar Gala wrote:
> On Jun 20, 2006, at 3:47 AM, Anton Blanchard wrote:
> > +			while (cells--)
> > +				*val = (*val << 32) | *fp++;
> 
> Is it reasonable for cells to be greater than 1 on a 32-bit system?   
> If not, ok to protect this with a CONFIG_PPC64

Well, large values will be broken on 32-bit no matter what right now:

  CC      arch/powerpc/kernel/time.o
arch/powerpc/kernel/time.c: In function ‘get_freq’:
arch/powerpc/kernel/time.c:875: warning: left shift count >= width of type


-Olof
