Date: Fri, 26 Jan 2001 09:14:02 +0100 (MET)
From: Gabriel Paubert <paubert@iram.es>
To: Subodh Nijsure <SNijsure@SkyStream.com>
cc: "'linuxppc-embedded@lists.linuxppc.org'" <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: Problems with turn_on_mmu
In-Reply-To: <B25E2E5A003CD311B61E00902778AF2A0148B69D@server1.skystream.com>
Message-ID: <Pine.HPX.4.10.10101260900510.22074-100000@gra-ux1.iram.es>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Thu, 25 Jan 2001, Subodh Nijsure wrote:

> 1. I am novice in PowerPC assembler code ( yes doing the RTFM) Why does gdb
> hang when
>    I do 'stepi' on instruction rfi ?

Because rfi is impossible to trace: actually any instruction between the
setting of srr0/srr1 and rfi cannot be traced because the trace exception
destroys srr0 and srr1. A smart debugger would check for mtsrr0/mtsrr1/rfi
while single stepping, cache srr0/srr1 and emulate rfi. I've not yet
encountered a debugger which does this, and a bulletproof implementation
is impossible, i.e., you can't set a breakpoint between mtsrr0/mtsrr1 and
rfi and expect it to work.

	Regards,
	Gabriel.


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
