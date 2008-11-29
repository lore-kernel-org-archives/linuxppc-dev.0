Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <18737.52782.650416.444270@cargo.ozlabs.ibm.com>
Date: Sun, 30 Nov 2008 10:20:14 +1100
From: Paul Mackerras <paulus@samba.org>
To: roel kluin <roel.kluin@gmail.com>
Subject: Re: powerpc: hv{cs,
	si}_close() both unsigned hp->count and hvcsd->open_count
	cannot be negative
In-Reply-To: <4931201D.7060701@gmail.com>
References: <4931201D.7060701@gmail.com>
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

roel kluin writes:

> unsigned hp->count and hvcsd->open_count cannot be negative
...
> -	if (--hvcsd->open_count == 0) {
> +	if (hvcsd->open_count == 1) {
> +		hvcsd->open_count--;

Why are we no longer decrementing hvcsd->open_count in the cases where
it is greater than 1?

> -	if (--hp->count == 0) {
> +	if (hp->count == 1) {
> +		hp->count--;

Ditto with hp->count here?

Also, I don't see why those changes have anything to do with "unsigned
things cannot be negative".  As long as those counts are never zero on
entry to those code sections, the existing code is fine, and I believe
that assertion can be maintained.  If you believe the code needs to
defend against the possibility of a zero count on entry, that should
have been explicitly stated in the patch description.

Paul.
