From: "Benjamin Herrenschmidt" <benh@kernel.crashing.org>
To: "Segher Boessenkool" <segher@koffie.nl>,
	<linuxppc-dev@lists.linuxppc.org>
Subject: Re: RFC: Performance Monitor Counters device
Date: Thu, 12 Sep 2002 11:52:17 +0200
Message-Id: <20020912095217.449@192.168.4.1>
In-Reply-To: <3D80F2F7.3FB3AE4B@koffie.nl>
References: <3D80F2F7.3FB3AE4B@koffie.nl>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


>For 2), you need the same as for 1), plus have the kernel
>generate a signal on every Nth occurence of some event.  The
>PowerPC generates an exception for that, so this is not all
>that hard either.  Maybe the kernel can communicate which PMC
>set off the signal; if not, it's trivial for the userland to
>figure that out from the current counters.

Hrm... you should check the various CPU erratas, I think
the perf. counter exception suffers from the same bugs
the thermal exceptions has regarding clashing with DEC
and thus losing exception context information on some
G4s. If this is the case, that would basically prevent
using it.

Ben.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
