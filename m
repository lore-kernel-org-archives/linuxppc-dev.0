Return-Path: <paulus@ozlabs.org>
Date: Tue, 5 Feb 2013 15:09:02 +1100
From: Paul Mackerras <paulus@samba.org>
To: linuxppc-dev@ozlabs.org, Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Alexander Graf <agraf@suse.de>
Subject: [PATCH 0/4] Improve CFAR handling
Message-ID: <20130205040902.GA20303@drongo>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: kvm-ppc@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The CFAR (Come From Address Register) is useful for debugging; it
records the address of the most recent taken branch or rfid
instructions.  At present, KVM doesn't even try to context switch it,
and the first-level interrupt handlers for some interrupts have a
branch before it gets saved, which will corrupt it.

This series fixes the interrupt handlers to not corrupt the CFAR, and
makes KVM context-switch it.  The series is against Ben H.'s
next branch.  The last patch in the series corrects a compile error
for 32-bit PR KVM configs which was introduced by an earlier commit in
Ben's next branch.

I suggest this series should go via Ben's tree rather than the KVM
tree, since most of the changes are to core powerpc interrupt handling
code.  Alex, if you could ack patch 3/4 that would be helpful.

Paul.
