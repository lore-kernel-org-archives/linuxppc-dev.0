Reply-To: <manu@stapf.org>
From: "Emmanuel STAPF" <manu@stapf.org>
To: <linuxppc-dev@lists.linuxppc.org>
Subject: Strange warning during C compilation
Date: Tue, 6 Nov 2001 00:55:19 -0800
Message-ID: <002701c166a0$c33d0080$f5732c0c@venice2>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
In-Reply-To: <000401c15d6d$77730690$f5732c0c@venice2>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi,

I'm getting the following warning: warning: pasting "h" and "(" does not
give a valid preprocessing token

Here is the piece of code that shows the problem:

#define CAT(a,b)a ## b
#define TEST_MACRO(n,c,a)       (CAT(n,_done) ? CAT(n,_result) :
CAT(c,a))

extern void* h();
extern void f(void*);
extern void* h_result;
extern char h_done;

void k (void* titi)
{
        f((TEST_MACRO(h,h,())));
}

If you save this code in a test.c file and use `gcc -Wall -c test.c'
here is what you get:

test.c:11:12: warning: pasting "h" and "(" does not give a valid
preprocessing token

Any idea what is wrong here? My gcc version is 3.01. It was also
happening on my gcc version 2.96 with a slightly different error
message: warning: pasting would not give a valid preprocessing token. I
tried with an even older version (2.7.2.3) and no warnings.

Regards,
Manu


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
