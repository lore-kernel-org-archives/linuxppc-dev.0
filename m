Return-Path: <miltonm@bga.com>
Received: from ruth.realtime.net (mercury.realtime.net [205.238.132.86])
	by ozlabs.org (Postfix) with ESMTP id C775ADDFAA
	for <linuxppc-dev@ozlabs.org>; Sat, 26 Jul 2008 14:23:39 +1000 (EST)
In-Reply-To: <488A44DB.7090400@austin.ibm.com>
References: <488A44DB.7090400@austin.ibm.com>
Mime-Version: 1.0 (Apple Message framework v624)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <55352adb7411e87b6c4dd948fc623936@bga.com>
From: Milton Miller <miltonm@bga.com>
Subject: [PATCH] Memset the kernel copy of rtas args before using
Date: Fri, 25 Jul 2008 23:17:10 -0500
To: Nathan Fontenot <nfont@austin.ibm.com>
Cc: ppcdev <linuxppc-dev@ozlabs.org>, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Sat Jul 26 at 07:25:47 EST in 2008, Nathan Fontenot wrote:
> The kernel copy of the rtas args struct that is read in from
> user space is a stack variable.  This structure should be
> zero'ed out before we do any reads/writes to/from the user
> when handling a rtas call request.  This patch adds a memset
> to do this.

Why bother to zero the data before copying from the user?  We
check that they supply data for the whole input range needed.

> I am seeing an issue in testing partition mobility, where the
> parts of the rtas args struct that return status top the user
> contain stale data.

Please change the patch to just clear the output arg range.
(I"m fine not trusting firmware to set all output args based
on what the user suggested the return arg count would be).

And we can do it after we decide not to return an error:

  792         if (args.token == RTAS_UNKNOWN_SERVICE)
  793                 return -EINVAL;
  794
  795         /* Need to handle ibm,suspend_me call specially */


milton
