Subject: Re: chrp mmu and booting.
From: Peter Bergner <bergner@vnet.ibm.com>
To: Sven Luther <sven.luther@wanadoo.fr>
Cc: linuxppc-dev list <linuxppc-dev@lists.linuxppc.org>
In-Reply-To: <20040123111725.GB23537@iliana>
References: <20040123111725.GB23537@iliana>
Content-Type: text/plain
Message-Id: <1074883450.2842.9.camel@otta.rchland.ibm.com>
Mime-Version: 1.0
Date: Fri, 23 Jan 2004 12:44:10 -0600
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Fri, 2004-01-23 at 05:17, Sven Luther wrote:
> Now, does this mean that the chrp of does enable the mmu before booting,
> and does program it in a way so that the translate (0) call will result
> in 0x10000, or do i miss something ?

On IBM CHRP hardware, OF executes in real mode (ie, relocate off).  It
then branches to yaboot/kernel still in real mode.  It's not until a
fair ways into the kernel boot that we turn relocate on (after we're
done making calls to OF).  This also means that Yaboot executes in
real mode as well on IBM CHRP machines.


Peter


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
