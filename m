Return-Path: <jk@ozlabs.org>
From: Jeremy Kerr <jk@ozlabs.org>
To: cbe-oss-dev@ozlabs.org
Subject: Re: [Cbe-oss-dev] 2.6.26-rc6 kernel bug on PS3?
Date: Thu, 26 Jun 2008 10:46:16 +1000
References: <OFD9B4725E.630B28FC-ONC1257473.00470E7C-C1257473.00479305@de.ibm.com>
In-Reply-To: <OFD9B4725E.630B28FC-ONC1257473.00470E7C-C1257473.00479305@de.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-6"
Message-Id: <200806261046.16763.jk@ozlabs.org>
Cc: linuxppc-dev@ozlabs.org, Stefan Wald <WALD@de.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi Stefan,

> Application hangs after a while defunct and dmesg output looks like
> d.txt. (See attached file: d.txt)

Looks like this is caused by doing the mmput() while the state mutex is 
held in spu_forget.

In your case, the mm is the final reference to the context, so this is 
resulting in a destroy_spu_context, which requires the state mutex :)

I'm going to take a look at the sequencing of spu_forget, but would like 
to write a test case. Could you tell us about the exit path of your 
program?

Cheers,


Jeremy
