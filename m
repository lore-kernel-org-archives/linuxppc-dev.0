Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <18079.63067.248965.356540@cargo.ozlabs.ibm.com>
Date: Fri, 20 Jul 2007 09:40:11 +1000
From: Paul Mackerras <paulus@samba.org>
To: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH] Treat ISI faults as read faults on classic 32-bit PowerPC
In-Reply-To: <FB9F7C22-8598-4E72-B663-130A7989925D@kernel.crashing.org>
References: <11847726193856-git-send-email-segher@kernel.crashing.org>
	<5d56173bee3f9ea0050aa508e7f27cc932af7229.1184104284.git.segher@kernel.crashing.org>
	<18078.43412.493174.590540@cargo.ozlabs.ibm.com>
	<FB9F7C22-8598-4E72-B663-130A7989925D@kernel.crashing.org>
Cc: linuxppc-dev@ozlabs.org, Johannes Berg <johannes@sipsolutions.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Segher Boessenkool writes:

> Should you really be testing VM_READ|VM_WRITE, or should it just
> be VM_READ?

We test VM_READ | VM_WRITE | VM_EXEC in the read case below, and that
is because we have no HPTE encoding to say "writable but not readable"
or "executable but not readable".  Similarly we have no encoding to
say "writable but not executable" on classic processors, so if you
have just VM_WRITE set, you get a page that is readable, writable and
executable.

Paul.
