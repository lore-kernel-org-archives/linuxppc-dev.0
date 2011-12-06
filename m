Return-Path: <paulus@ozlabs.org>
Date: Tue, 6 Dec 2011 15:03:00 +1100
From: Paul Mackerras <paulus@samba.org>
To: Alexander Graf <agraf@suse.de>, Scott Wood <scottwood@freescale.com>
Subject: "KVM: PPC: booke: Improve timer register emulation" breaks Book3s HV
Message-ID: <20111206040300.GA12018@drongo>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linuxppc-dev@ozlabs.org, kvm-ppc@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

I'm not sure why yet, but commit 8a97c432 ("KVM: PPC: booke: Improve
timer register emulation") in Alex's kvm-ppc-next branch is breaking
Book3S HV KVM on POWER7.  Guest cpus fail to spin up, and even with
just one cpu, the guest stalls every so often.  If I stop the guest
and inspect the state with qemu, PC is at 0x900.  Reverting 8a97c432
makes it work properly again.

Paul.
