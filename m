To: "Embedded Linux PPC list" <linuxppc-embedded@lists.linuxppc.org>
Subject: BAT mapping exported to user-space
Reply-To: "Embedded Linux PPC list" <linuxppc-embedded@lists.linuxppc.org>
From: "Linh Dang" <linh@linhdang.home>
Date: Mon, 26 Jul 2004 13:20:40 -0400
Message-ID: <wn5wu0qsn13.fsf@linhd-2.ca.nortel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi all,

In our project, our application continuously does random-access to
various ASICs. The ASICs are mapped by a bat register:

- Forcing the application to use system-calls for accessing the ASICs
  would incur a too-big overhead.

- Adding _PAGE_USER to bat-mapping is ok but would export the mapping
  to every single userspace processes.

- I'm contemplating adding 2 bitmasks (1 read, 1 write) into the
  mm_struct:
  - each bit in the mask represent a BAT register that should be
    accessible from userspace.
  - in switch_mm, prior to the call to set_context(), the BATs's Vp
    bits would be updated based on the masks of the `next' mm.

My questions are:
- has it been discussed/comptemplate/done before?
- what issues (performance,style,...) do you think such a change would
  create?
- How the X server access the hw on PPC?


Thanx

--
Linh Dang

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
