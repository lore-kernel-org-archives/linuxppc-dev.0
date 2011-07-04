Return-Path: <anton@samba.org>
Date: Mon, 4 Jul 2011 20:57:38 +1000
From: Anton Blanchard <anton@samba.org>
To: benh@kernel.crashing.org, brueckner@linux.vnet.ibm.com,
	borntraeger@de.ibm.com, linuxppc-dev@lists.ozlabs.org
Subject: hvc_console change results in corrupt oops output
Message-ID: <20110704205738.742e56d0@kryten>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


Hi,

We've been struggling to debug a hang on a large ppc64 box. Every time
we collect oops output there are pieces of the oops output missing and
in some cases entire CPUs are missing.

Eventually I realised the hvc_console driver is dropping characters.
The commit that caused this is:


commit 3feebbb5492e9e463467cefb633e23a3dfcec132
Author: Hendrik Brueckner <brueckner@linux.vnet.ibm.com>
Date:   Mon Oct 13 23:12:50 2008 +0000

    hvc_console: Fix loop if put_char() returns 0
    
    If put_char() routine of a hvc console backend returns 0, then the
    hvc console starts looping in the following scenarios:
    
    1. hvc_console_print()
        If put_char() returns 0 then the while loop may loop forever.
        I have added the missing check for 0 to throw away console
        messages.


The hypervisor gives us a busy return, so we could retry a number of
times instead of dropping it on the floor. We'd need to do it in the
hvc_console driver - the tty drivers share the same backend
functions so we can't hide it in the pseries put_chars function.

Anton
