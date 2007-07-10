Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <18066.53384.449544.952545@cargo.ozlabs.ibm.com>
Date: Tue, 10 Jul 2007 10:19:20 +1000
From: Paul Mackerras <paulus@samba.org>
To: Manish Ahuja <ahuja@austin.ibm.com>
Subject: Re: [PATCH] Infinite loop/always true check possible with unsigned
	counter.
In-Reply-To: <46928691.2040008@austin.ibm.com>
References: <469270F3.4070206@austin.ibm.com> <46928691.2040008@austin.ibm.com>
Cc: ppc-dev <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Manish Ahuja writes:

> Repost to fix my email id.
> 
> Fix to correct a possible infinite loop or an always true check when the 
> unsigned long counter "i" is used in
> lmb_add_region() in the following for loop:
> 
> for (i = rgn->cnt-1; i >= 0; i--)

Unfortunately this won't fix the bug.  Since rgn->cnt is unsigned
long, the comparison will be done as an unsigned comparison even if i
is signed.

Instead, change the loop to go from rgn->cnt down to 1, and in the
loop body, change all instances of "i+1" to "i", and "i" to "i-1".

Paul.
