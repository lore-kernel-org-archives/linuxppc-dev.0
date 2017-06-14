Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wnl594Q5VzDqL3
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 14 Jun 2017 21:38:37 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Nicholas Piggin <npiggin@gmail.com>, linuxppc-dev@lists.ozlabs.org
Cc: "Gautham R . Shenoy" <ego@linux.vnet.ibm.com>,
 Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [PATCH 12/13] powerpc/64: runlatch CTRL[RUN] set optimisation
In-Reply-To: <20170613130557.26315-13-npiggin@gmail.com>
References: <20170613130557.26315-1-npiggin@gmail.com>
 <20170613130557.26315-13-npiggin@gmail.com>
Date: Wed, 14 Jun 2017 21:38:36 +1000
Message-ID: <87h8zi3ikj.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Nicholas Piggin <npiggin@gmail.com> writes:

> The CTRL register is read-only except bit 63 which is the run latch
> control. This means it can be updated with a mtspr rather than
> mfspr/mtspr.

Turns out this doesn't work on Cell.

There's an extra field in there:

  Thread enable bits (Read/Write)
  The hypervisor state can suspend its own thread by setting the TE bit
  for its thread to '0=E2=80=99. The hypervisor state can resume the opposi=
te
  thread by setting the TE bit for the opposite thread to '1'. The
  hypervisor state cannot suspend the opposite thread by setting the TE
  bit for the opposite thread to =E2=80=980=E2=80=99. This setting is ignor=
ed and does not
  cause an error.
=20=20
  TE0 is the thread enable bit for thread 0.
  TE1 is the thread enable bit for thread 1.
=20=20
  If thread 0 executes the mtctrl instruction, these are the bit values:
=20=20
  [TE0 TE1] Description
    0   0   Disable or suspend thread 0; thread 1 unchanged.
    0   1   Disable or suspend thread 0; enable or resume thread 1 if it wa=
s disabled.
    1   0   Unchanged.
    1   1   Enable or resume thread 1 if it was disabled.
=20=20
  If thread 1 executes the mtctrl instruction, these are the bit values:
=20=20
  [TE0 TE1] Description
    0   0    Thread 0 unchanged; disable or suspend thread 1.
    0   1    Unchanged.
    1   0    Enable or resume thread 0 if it was disabled; disable or suspe=
nd thread 1.
    1   1    Enable or resume thread 0 if it was disabled.


So writing either 0 or CTRL_RUNLATCH (1) will disable the thread that
does the write - :D

For now I'll just drop this.

cheers
