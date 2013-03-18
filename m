Return-Path: <michael@ellerman.id.au>
Date: Mon, 18 Mar 2013 18:01:11 +1100
From: Michael Ellerman <michael@ellerman.id.au>
To: linuxppc-dev@ozlabs.org, paulus@samba.org, benh@kernel.crashing.org
Subject: KVM breaking the ppc64_defconfig UP build
Message-ID: <20130318070111.GA9093@concordia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi guys,

The ppc64_defconfig build with CONFIG_SMP=n (ie. UP) is broken by KVM:

  arch/powerpc/kvm/book3s_hv.c:1855:2: error: implicit declaration of function 'inhibit_secondary_onlining'
  arch/powerpc/kvm/book3s_hv.c:1862:2: error: implicit declaration of function 'uninhibit_secondary_onlining'

http://kisskb.ellerman.id.au/kisskb/buildresult/8400164/

The fix for that is fairly easy.


Once that's fixed there is breakage in arch/powerpc/kvm/book3s_hv_interrupts.S
caused by us calling smp_send_reschedule() to cause a self-IPI on 970.

It's not clear to me how we fix that one, any ideas?

cheers
