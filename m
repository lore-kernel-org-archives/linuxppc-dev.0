Reply-To: <acurtis@onz.com>
From: "Allen Curtis" <acurtis@onz.com>
To: "Sylvain Latulippe" <slatulippe@mediatrix.com>,
	<linuxppc-embedded@lists.linuxppc.org>
Subject: RE: 8260 FCC and local bus
Date: Tue, 24 Sep 2002 09:25:06 -0700
Message-ID: <NCBBIINEHIPFGJPLBEIFKEHHDMAA.acurtis@onz.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
In-Reply-To: <2702075D4DE2B043BF5EB82E9CFAD45B0CAD23@mail1.mediatrix.com>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


> I have found some information in the mailing list regarding usage of local
> bus ram for FCC BD's and buffers.  However I haven't found any
> conclusion if
> it's working.

Yes, you can use local RAM for the BD's and buffers. There is a penalty
because you need to move the buffers between local and 60X RAM. I have found
information on the list indicating that you can use IDMA for this purpose.
(search with the keyword "profiling" in embedded)

> Has anyone done it successfully?
> What kind of support does linux provide regarding local bus ram? (Ram
> drive,...)

No real support for local RAM per say. You need to treat it as any other
memory mapped device. Therefore you need to change all _va()/_pa() calls to
ioremap() and iopa().

Note: If you are using rev-A 8260 processors, this helps a lot.


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
