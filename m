Return-Path: <prashant.alange@gmail.com>
Received: from rproxy.gmail.com (rproxy.gmail.com [64.233.170.206])
	by ozlabs.org (Postfix) with ESMTP id E27E668003
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 10 Aug 2005 07:50:35 +1000 (EST)
Received: by rproxy.gmail.com with SMTP id b11so4995rne
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 09 Aug 2005 14:50:34 -0700 (PDT)
Message-ID: <6d145b4205080914506cbc5e80@mail.gmail.com>
Date: Tue, 9 Aug 2005 14:50:33 -0700
From: Prashant Alange <prashant.alange@gmail.com>
To: Dan Malek <dan@embeddededge.com>
In-Reply-To: <e0e99d07a5f20187cf45caac1ee9fa10@embeddededge.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <6d145b42050808193058ee05b4@mail.gmail.com>
	<5c9191bc3e15d90c966735662c28fa5e@embeddededge.com>
	<6d145b42050809075718c70574@mail.gmail.com>
	<e0e99d07a5f20187cf45caac1ee9fa10@embeddededge.com>
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: How to disable dcache on MPC82xx platform
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Thanks Dan for your explaination. I am linking multiple BDs only but
no of BDs are very large in my case so I am allocating the memory and
updating the BD pointer for all BDs. I am thinking of using mem start
parameter option. I even tried using __get_free_page instead of using
cpm_hostalloc() but that also did not help.
If i use mem=3D option as kernel command line argument then I will have
to just ioremap() this reserved address in my driver and start
accessing the memory.  I do not have to worry about cache related
things.  right?

Thanks again,
Prashant


On 8/9/05, Dan Malek <dan@embeddededge.com> wrote:
>=20
> On Aug 9, 2005, at 10:57 AM, Prashant Alange wrote:
>=20
> > Since the existing UART/ethernet drivers are using cpm_hostalloc() so
> > I am also using the same function.
>=20
> As I have said too many times before, cpm_hostalloc() is only used
> to allocate small memory regions that would otherwise be wasteful
> with the normal Linux memory allocators.  This function does not
> do anything special with the memory, aside from allowing us have
> multiple drivers share a page for efficiency.
>=20
> >  Then can I use kmalloc() to alloc
> > such huge memory.
>=20
> Yes, and you should.
>=20
> >  If at all I have to configure BATx to just test how
> > it behaves.
>=20
> No, that's not all you have to do.  It's not a trivial process
> easily described here.
>=20
> > .....   One more thing is that
> > totally I am allocating about 1MB memory in a chunk of 200K.
>=20
> I can't comprehend a reason why you need to allocate so much
> space in a driver, especially for CPM devices.  The driver is just
> a temporary FIFO for data flowing to/from other consumer/producers
> of the data in the system.  If the software above a driver needs
> that kind of buffering, it should manage that itself.
>=20
> If you do need so much space, use the beauty of the CPM and
> link multiple BDs with reasonable sized buffers more easily
> managed by the existing Linux allocators.
>=20
> The other alternative is just reserve memory using the 'mem=3D'
> start parameter so it isn't know to Linux, and manage entirely
> yourself.
>=20
>=20
>        -- Dan
>=20
>
