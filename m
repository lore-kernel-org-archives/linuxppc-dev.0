Date: Wed, 13 Sep 2000 20:13:01 -0500 (CDT)
From: Takashi Oe <toe@unlserve.unl.edu>
To: Michel Lanners <mlan@cpu.lu>
cc: bh40@calva.net, costabel@wanadoo.fr, paulus@linuxcare.com,
        linuxppc-dev@lists.linuxppc.org
Subject: Re: success 2.4.0-test8 with latest bk
In-Reply-To: <200009132025.WAA00853@piglet.grunz.lu>
Message-ID: <Pine.A41.3.96LJ1.1b7.1000913195933.37860A-100000@unlserve.unl.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Wed, 13 Sep 2000, Michel Lanners wrote:

> On  13 Sep, this message from Benjamin Herrenschmidt echoed through cyberspace:
> >>Update: After a recompilation with today's updates, the latest bk kernel
> >>boots again for me.
> >
> > That's not the first time I notice this strange behaviour. I meant, this
> > happened to me randomly with various bk kernels for monthes. The problem
> > usually disappeared by itself after either recompiling the entire kernel,
> > or changing a few unrelated lines of code and then reompiling. That's
> > weird, I really don't know what can be causing that.
>
> Same for me, except that for a few weeks now I'm basically stuck in a
> non-booting mood. One out of roughly 20 tries boots indeed; all the
> other stop in various places in init/main.c. Not even going into xmon...
>
> Since it doesn't seem to be a reproducible crash in one specific place,
> its rather hard to isolate the problem. I feel like chasing ghosts...
> Anybody got Ghostbusters' phone?

Could you try the following change for arch/ppc/mm/init.c?


static void __init
clear_hash_table(void)
{
	unsigned char *adr = (unsigned char *)Hash;
	unsigned long i = Hash_size;

	for (; i > 0; --i)
		*adr++ = 0;
}

/*
 * Initialize the hash table and patch the instructions in head.S.
 */
static void __init hash_init(void)
{
	int Hash_bits, mb, mb2;
	....
	....
	if ( ppc_md.progress ) ppc_md.progress("hash:find piece", 0x322);
	/* Find some memory for the hash table. */
	if ( Hash_size ) {
		Hash = mem_pieces_find(Hash_size, Hash_size);
		clear_hash_table();
	} else
		Hash = 0;
	....
	....
}


I was seeing the random freezes until I made this change.  What it does is
to zero out the hash table *before* anybody tries to use it.  I think that
is at least sensible thing to do.  For your machine, you can probably
replace "clear_hash_table()" by memset(Hash,0,Hash_size) or something and
be done with it.  The helper function is to avoid taking exception on
NuBus machines this early in boot process.

Actually, I've sent a message to this list months ago asking why the hash
table is never initialized but no one seemed to care at the time.
Perhaps, this time, someone would care to comment?  I still fail to see
why it's not necessary anyhow.

Martin's boot problem is certainly something else since his machine (603e)
doesn't use Hash.

For me, 2.4.0-test8 + fs/buffer.c fix has been very stable.


Takashi Oe


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
