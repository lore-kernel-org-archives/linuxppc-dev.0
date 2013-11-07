Return-Path: <anton@samba.org>
Date: Thu, 7 Nov 2013 13:07:03 +1100
From: Anton Blanchard <anton@samba.org>
To: Michael Neuling <mikey@neuling.org>
Subject: Re: [PATCH] powerpc: memcpy optimization for 64bit LE
Message-ID: <20131107130703.482e8232@kryten>
In-Reply-To: <11438.1383718966@ale.ozlabs.ibm.com>
References: <1383640732-21449-1-git-send-email-felix@linux.vnet.ibm.com>
 <11438.1383718966@ale.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: Philippe Bergheaud <felix@linux.vnet.ibm.com>,
 Linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


Hi,

> > Unaligned stores take alignment exceptions on POWER7 running in
> > little-endian. This is a dumb little-endian base memcpy that
> > prevents unaligned stores. It is replaced by the VMX memcpy at boot.
> 
> Is this any faster than the generic version?

Once booted the feature fixup code switches us over to the VMX copy
loops (which are already endian safe).

The question is what we do before that switch over. The base 64bit
memcpy takes alignment exceptions on POWER7 so we can't use it as is.
Fixing the causes of alignment exception would slow it down, because
we'd need to ensure all loads and stores are aligned either through
rotate tricks or bytewise loads and stores. Either would be bad for
all other 64bit platforms.

Anton
