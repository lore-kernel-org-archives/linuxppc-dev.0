From: Paul Mackerras <paulus@samba.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <15181.18002.484704.634903@cargo.ozlabs.ibm.com>
Date: Thu, 12 Jul 2001 16:40:18 +1000 (EST)
To: ashish anand <ashisha@india.infogain.com>
Cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: PCI BAR initialisation..?
In-Reply-To: <3B4C0567.9BC25E5B@india.infogain.com>
References: <3B4C0567.9BC25E5B@india.infogain.com>
Reply-To: paulus@samba.org
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


ashish anand writes:

> But by any chance if somebody has come across a random feature of pci BAR.
> that is if you write the required pci addresses in BAR after writing 0xffffffff and
> reading it back , and to confirm if the actual value has reached the BAR , we read it again
> but then it returns funny values.
>
> more surprisingly if i move the code in some other function then everything behaves correctly.
> I am more then sure that nothing relevant is happening betwen two places.

Hmmm, that sounds like maybe the config space reads and writes are
getting reordered, which would be a Bad Thing.

What sort of PCI host bridge does your system have?

If you place an mb() call after each pci config read or write, does
that fix the problem?

Paul.

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
