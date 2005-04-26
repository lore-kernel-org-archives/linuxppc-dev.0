Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <17006.51472.810425.380781@cargo.ozlabs.ibm.com>
Date: Wed, 27 Apr 2005 09:04:48 +1000
From: Paul Mackerras <paulus@samba.org>
To: "Stuart Yoder" <stuart.yoder@conformative.com>
In-Reply-To: <054301c54a6f$d1cf82b0$2f010a0a@foundation.com>
References: <1114486594.7183.12.camel@gaston>
	<054301c54a6f$d1cf82b0$2f010a0a@foundation.com>
Cc: 'linuxppc-dev list' <linuxppc-dev@ozlabs.org>
Subject: RE: PowerPC + SMP
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Stuart Yoder writes:

> That raises a question though-- how can I know what assumptions the
> kernel makes about the state of the CPU/system when it begins execution?
> Is this clearly documented anywhere?

In general the kernel assumes that firmware has set up the HID
registers, caches, northbridge, memory controller, memory, etc., in a
suitable state for the machine to run at full speed.  There is code to
set and clear various HID bits, depending on the specific cpu model -
look for the __setup_cpu_* functions in arch/ppc/kernel/*.S.  I guess
we could add code to set ABE and SYNCBE on 7447A processors on SMP
systems; I can't imagine that any SMP system would require them to be
clear.

Paul.
