Return-Path: <hollis@penguinppc.org>
Received: from out3.smtp.messagingengine.com (out3.smtp.messagingengine.com
	[66.111.4.27]) by ozlabs.org (Postfix) with ESMTP id A1FFB67A70
	for <linuxppc-dev@ozlabs.org>; Wed, 24 May 2006 01:25:14 +1000 (EST)
Subject: Re: snd-aoa status update / automatic driver loading
From: Hollis Blanchard <hollis@penguinppc.org>
To: Johannes Berg <johannes@sipsolutions.net>
In-Reply-To: <1148395617.3434.0.camel@diesel>
References: <1147860564.14395.6.camel@johannes>
	<20060522221138.683790c2@diesel>  <1148387282.25971.8.camel@johannes>
	<1148395617.3434.0.camel@diesel>
Content-Type: text/plain
Date: Tue, 23 May 2006 10:25:45 -0500
Message-Id: <1148397945.13003.3.camel@basalt.austin.ibm.com>
Mime-Version: 1.0
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>,
	debian-powerpc <debian-powerpc@lists.debian.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, 2006-05-23 at 09:46 -0500, Hollis Blanchard wrote:
> 
> Could you also add a sample modules.conf? For example, users should be
> told to remove snd-powermac. Here's what I have ATM, on an FC5 system:
> alias snd-card-0 i2sbus
> remove snd-card-0 { /usr/sbin/alsactl store 0 >/dev/null 2>&1
> || : ; }; /sbin/modprobe -r --ignore-remove snd-powermac

Oops, obviously that last "snd-powermac" shouldn't be there; I just
edited what FC5 had put there and I missed a spot. Maybe this will be
better:
alias snd-card-0 i2sbus
remove i2sbus { /usr/sbin/alsactl store 0 >/dev/null 2>&1 || : ; }; /sbin/modprobe -r --ignore-remove i2sbus

Also, the file is called modprobe.conf... :)

-Hollis
