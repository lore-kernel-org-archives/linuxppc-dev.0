From: pnilesh@in.ibm.com
To: linuxppc-dev@lists.linuxppc.org
Message-ID: <CA256A07.003DA9D3.00@d73mta05.au.ibm.com>
Date: Tue, 6 Mar 2001 16:34:04 +0530
Subject: strange sigaction ()
Mime-Version: 1.0
Content-type: text/plain; charset=iso-8859-1
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


I am seeing a strange problem with sigaction on powerpc.

static struct sigaction act;
static void handler (int,siginfo_t *,void *);
main ()
{
sigaction (SIGALRM,&act,NULL);
alarm (1);
sleep (2);
}

void handler (int x, siginfo_t *s,void *v)
{
    printf ("si_signo   = %d, si_code  = %d, si_errno  = %d\n",s->si_signo,
s->si_code, s->si_errno);
}

This program gives meaningful values on Linux Intel Redhat.
On Apple Dual G4 PowerPC I am getting junk values
si_signo = 805464356
si_errno = 805464640
si_code = 21

I dont know what is happening.
Please educate me.

Nilesh


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
