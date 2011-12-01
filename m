Return-Path: <anton@samba.org>
Date: Thu, 1 Dec 2011 13:26:22 +1100
From: Anton Blanchard <anton@samba.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH] powerpc/nvram: Add spinlock to oops_to_nvram to prevent
 oops in compression code.
Message-ID: <20111201132622.2b23a1d7@kryten>
In-Reply-To: <1322705472.3729.11.camel@pasglop>
References: <20111201124645.24c6e54f@kryten> <1322705472.3729.11.camel@pasglop>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: jkenisto@us.ibm.com, paulus@samba.org, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Ben,

> How would we miss ?
> 
> trylock does loop on stwcx. failure, it doesn't loop if the lock is
> -taken-, so if the lock is only used for actually dealing with the
> oops the only "miss" is because somebody already got it... or am I
> missing something ?

I'm thinking of two CPUs that enter at exactly the same time either
through a system reset or an ugly bug (writing junk at 0x900 so the
decrementer exception gets an oops). Probably unlikely enough that we
don't care.

Anton
