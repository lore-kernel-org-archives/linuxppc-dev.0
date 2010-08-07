Return-Path: <psmith@gnu.org>
Received: from cpoproxy1-pub.bluehost.com (cpoproxy1-pub.bluehost.com
	[69.89.21.11]) by ozlabs.org (Postfix) with SMTP id E57E5B6EEE
	for <linuxppc-dev@ozlabs.org>; Sun,  8 Aug 2010 03:56:48 +1000 (EST)
Subject: Re: make 3.82 fails on powerpc defconfig update [was: Linux 2.6.35]
From: Paul Smith <psmith@gnu.org>
To: Thomas Backlund <tmb@mandriva.org>
In-Reply-To: <4C5686FF.9010803@mandriva.org>
References: <AANLkTim8FALeVG+NPLNLEQChu=dPD=GHSpnxmZHYgsNx@mail.gmail.com>
	<4C5686FF.9010803@mandriva.org>
Content-Type: text/plain; charset="us-ascii"
Date: Sat, 07 Aug 2010 13:56:43 -0400
Message-ID: <1281203803.5923.164.camel@homebase>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, bug-make@gnu.org
Reply-To: psmith@gnu.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 2010-08-02 at 11:51 +0300, Thomas Backlund wrote:
> BOOT_TARGETS = zImage zImage.initrd uImage zImage% dtbImage%
> treeImage.% cuImage.% simpleImage.%
> 
> Now, I dont know if this is "intended breakage" by the make update, or 
> if the Makefile needs to be updated....

The change is intentional.  Note, though, that this syntax was always
dodgy, even in previous versions of GNU make.

If you wrote it exactly as you did, where all the explicit targets come
first and all the implicit targets come second, then it seems to have
been interpreted correctly.

However, if you did it any other way (for example, put some explicit
targets after the first implicit target) then make would silently throw
away all the targets starting with the first implicit target.

Since the syntax used here wasn't ever described in the documentation,
rather than reworking it as a new feature I decided to follow the docs
and disallow it, and be verbose about the error.

-- 
-------------------------------------------------------------------------------
 Paul D. Smith <psmith@gnu.org>          Find some GNU make tips at:
 http://www.gnu.org                      http://make.mad-scientist.net
 "Please remain calm...I may be mad, but I am a professional." --Mad Scientist
