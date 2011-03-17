Return-Path: <paulus@ozlabs.org>
Date: Thu, 17 Mar 2011 15:20:56 +1100
From: Paul Mackerras <paulus@samba.org>
To: mjw@us.ibm.com
Subject: Re: [PATCH v2] powerpc/ptrace: remove BUG_ON when full register
	set not available
Message-ID: <20110317042056.GA29602@drongo>
References: <1300282642.15145.2.camel@w500>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1300282642.15145.2.camel@w500>
Cc: linuxppc-dev@ozlabs.org, mikey@neuling.org, anton@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Mar 16, 2011 at 08:37:22AM -0500, Michael Wolf wrote:

> In some cases during a threaded core dump not all 
> the threads will have a full register set.  This
> will cause problems when the sigkill is sent to
> the thread.  To solve this problem a poison value
> (0xdeadbeef) will be placed in the buffer in place 
> of the actual register values.  This will affect
> gpr14 to gpr31.

To be clear, this happens when the signal causing the core dump races
with a thread exiting.  The race happens when the exiting thread has
entered the kernel for the last time before the signal arrives, but
doesn't get far enough through the exit code to avoid being included
in the core dump.  So we get a thread included in the core dump which
is never going to go out to userspace again and only has a partial
register set recorded.  Normally we would catch each thread as it is
about to go into userspace and capture the full register set then.
However, this exiting thread is never going to go out to userspace
again, so we have no way to capture its full register set.  It doesn't
really matter, though, as this is a thread which is effectively
already dead.

Paul.
